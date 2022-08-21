# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }
  let(:order_created) { create(:order) }
  let(:order_id_binance_canceled) { '184222891' }
  let(:order_id_binance_filled) { '184976569' }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:parent_order) }
    it { should belong_to(:trade_pair) }
    it { should have_one(:child_order).dependent(:nullify) }
    it { should have_one(:exchange).through(:trade_pair) }
  end

  describe 'VALIDATIONS' do
    it { should validate_inclusion_of(:buy_or_sell).in_array(%w[buy sell]) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:buy_or_sell) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'DELEGATES' do
    it { should delegate_method(:client).to(:trade_pair) }
    it { should delegate_method(:symbol).to(:trade_pair) }
  end

  describe 'CALLBACKS' do
    # describe 'after_update' do
    #   describe 'cancelling stale orders' do
    #     context 'when created order is a sell order' do
    #       before { order_created.update(buy_or_sell: 'sell') }

    #       it 'does not destroy the order' do
    #         expect(order_created.present?).to be true
    #       end
    #     end

    #     context 'when created order is a buy order' do
    #       before { order_created.update(buy_or_sell: 'buy') }

    #       it 'does not destroy the order' do
    #         expect(order_created.present?).to be true
    #       end

    #       context 'when created order is not open' do
    #         before { order_created.update(status: 'filled') }

    #         it 'does not destroy the order' do
    #           expect(order_created.present?).to be true
    #         end
    #       end

    #       context 'when created order is open' do
    #         before { order_created.update(status: 'open') }

    #         it 'does not destroy the order' do
    #           expect(order_created.present?).to be true
    #         end

    #         context 'when created order has been partially filled' do
    #           before { order_created.update!(quantity_received: 0.1) }

    #           it 'does not destroy the order' do
    #             expect(order_created.present?).to be true
    #           end
    #         end

    #         context 'when created order has not been filled' do
    #           before { order_created.update!(quantity_received: 0) }

    #           it 'does not destroy the order' do
    #             expect(order_created.present?).to be true
    #           end

    #           context 'when created order is less than a day old' do
    #             it 'does not destroy the order' do
    #               expect(order_created.present?).to be true
    #             end
    #           end

    #           context 'when created order is more than 12 hours old' do
    #             before { order_created.update!(created_at: Time.current - 13.hours) }

    #             it 'does not destroy the order' do
    #               expect(order_created.present?).to be true
    #             end

    #             context 'when exchange is binance' do
    #               before { order_created.exchange.update!(identifier: 'binance') }

    #               context 'when the cancel order to client to exchange is successful' do
    #                 before do
    #                   allow(order_created.client).to receive(:cancel_order!).and_return({})
    #                 end

    #                 it 'does not destroy the order' do
    #                   expect(order_created).to receive(:cancel)
    #                   order_created.save
    #                 end
    #               end
    #             end
    #           end
    #         end
    #       end
    #     end
    #   end
    # end

    describe 'before_validation' do
      context 'when buy_or_sell is present' do
        it 'downcases buy_or_sell' do
          order.buy_or_sell = 'BUY'
          order.save
          expect(order.buy_or_sell).to eq 'buy'
        end
      end
    end
  end

  describe 'INSTANCE METHODS' do
    describe '#create_counter' do
      context 'when order is for a sell' do
        before { order.buy_or_sell = 'sell' }

        it 'does not create a counter order' do
          expect(order.trade_pair).not_to receive(:create_order)
          order.create_counter
        end
      end

      context 'when order is for a buy' do
        before { order.buy_or_sell = 'buy' }

        context 'when next price is less than or equal to order price' do
          before { order.update!(quantity: 0, quantity_received: 0) }

          it 'should raise an error' do
            expect { order.create_counter }.to raise_error('Next price should be higher than current price')
          end
        end

        context 'when next quantity is greater than current quantity' do
          before do
            order.update!(quantity: 1, quantity_received: 1)
            allow(order.trade_pair).to receive(:amount_step).and_return(-1)
          end

          it 'should raise an error' do
            expect { order.create_counter }.to raise_error('Next quantity should be less than or equal to current quantity')
          end
        end

        context 'when next quantity is lower and next price is higher it' do
          before do
            order.update!(quantity: 1, quantity_received: 1)
            allow(order.trade_pair).to receive(:create_order)
          end

          it 'should call trade_pair.create_order' do
            next_quantity = order.quantity - order.trade_pair.amount_step
            next_price = (order.quantity_received * (1.0 + (order.taker_fee_for_calculation * 10))) / next_quantity
            expect(order.trade_pair).to receive(:create_order).with('sell', next_price, next_quantity, order.id)
            order.create_counter
          end
        end
      end
    end

    describe '#query' do
      context 'when order is with binance' do
        before { order_created.exchange.update!(identifier: 'binance') }

        context 'when symbol is registered with binance' do
          before { order_created.trade_pair.update!(symbol: 'bnbeth') }

          context 'when order_id is real' do
            context 'when order_id is for a canceled order' do
              before { order_created.update!(reference: order_id_binance_canceled) }

              # it 'is queries that order' do
              #   result = order_created.query
              #   expect(result['orderId']).to eq(order_id_binance_canceled.to_i)
              #   expect(order_created.query['status']).to eq('CANCELED')
              # end
            end

            context 'when order_id is for a filled order' do
              before { order_created.update!(reference: order_id_binance_filled) }

              # it 'is queries that order' do
              #   result = order_created.query
              #   expect(result['orderId']).to eq(order_id_binance_filled.to_i)
              #   expect(result['status']).to eq('FILLED')
              # end
            end
          end
        end
      end
    end

    describe '#update_from_exchange' do
      context 'when order is with binance' do
        before do
          order_created.exchange.update(identifier: 'binance')
          order_created.reload
        end

        context 'when symbol is not registered with binance' do
          before do
            order_created.trade_pair.update!(symbol: 'SHITCOIN')
          end

          it 'does not update the order' do
            expect(order_created).not_to receive(:update!)
            order_created.update_from_exchange
          end
        end

        context 'when symbol is registered with binance' do
          before { order_created.trade_pair.update!(symbol: 'bnbeth') }

          context 'when order_id is not legit' do
            before { order_created.update!(reference: 'fakeref') }

            it 'does not update the order' do
              expect(order_created).not_to receive(:update!)
              order_created.update_from_exchange
            end
          end

          context 'when order_id is legit' do
            context 'when order status is canceled' do
              before { order_created.update!(reference: order_id_binance_canceled) }

              it 'does updates the order' do
                expect(order_created).not_to receive(:update!)
                order_created.update_from_exchange
              end
            end

            context 'when order status is not canceled' do
              before { order_created.update!(reference: order_id_binance_filled) }

              # it 'does updates the order' do
              #   expect(order_created).to receive(:update!)
              #   order_created.update_from_exchange
              # end
            end
          end
        end
      end
    end
  end
end
