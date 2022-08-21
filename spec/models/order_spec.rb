# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order, quantity: 555, quantity_received: 555, trade_pair: trade_pair) }
  let(:order_created) { create(:order) }
  let(:order_id_binance_canceled) { '184222891' }
  let(:order_id_binance_filled) { '184976569' }
  let(:trade_pair) { create(:trade_pair, :fees_present, exchange: create(:exchange)) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:parent_order) }
    it { should belong_to(:trade_pair) }
    it { should have_one(:child_order).dependent(:nullify) }
    it { should have_one(:exchange).through(:trade_pair) }
  end

  describe 'ENUMS' do
    it {
      should define_enum_for(:status).with_values(open: 'open', filled: 'filled', cancelled_stale: 'cancelled_stale')
                                     .backed_by_column_of_type(:string)
    }
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
    describe 'after_save' do
      describe '#create_counter' do
        before { allow(trade_pair).to receive(:create_order) }

        context 'when order is a sell order' do
          before { order.buy_or_sell = 'sell' }

          it 'does not create a counter order' do
            order.save
            expect(trade_pair).not_to have_received(:create_order)
          end
        end

        context 'when order is a buy order' do
          before { order.buy_or_sell = 'buy' }

          context 'when order already has a child_order' do
            before { order.child_order = create(:order) }

            it 'does not create a counter order' do
              order.save
              expect(trade_pair).not_to have_received(:create_order)
            end
          end

          context 'when order does not have a child order' do
            before { order.child_order = nil }

            context 'when order is not filled' do
              before { order.status = 'open' }

              it 'does not create a counter order' do
                order.save
                expect(trade_pair).not_to have_received(:create_order)
              end
            end

            context 'when order is filled' do
              before { order.status = 'filled' }

              context 'when associated trade pair mode is not accumulate or counter_only' do
                before { trade_pair.mode = 'sell' }

                it 'does not create a counter order' do
                  order.save
                  expect(trade_pair).not_to have_received(:create_order)
                end
              end

              context 'when associated trade pair mode is accumulate or counter_only' do
                before { trade_pair.update!(mode: %w[accumulate counter_only].sample) }

                context 'when associated exchange is not binance' do
                  it 'does not create a counter order' do
                    order.save
                    expect(trade_pair).not_to have_received(:create_order)
                  end
                end

                context 'when associated exchange is binance' do
                  before do
                    order.trade_pair.exchange.update!(identifier: 'binance')
                  end

                  context 'when trade pair has an accumulate amount' do
                    before do
                      trade_pair.update!(accumulate_amount: 1, amount_step: 2)
                    end

                    it 'calls trade_pair.create_order with the correct amounts' do
                      order.save
                      next_quantity = order.quantity - trade_pair.accumulate_amount
                      next_price = (order.quantity_received * (1.0 + (order.taker_fee_for_calculation * 10))) / next_quantity
                      expect(trade_pair).to have_received(:create_order).with('sell', next_price, next_quantity, order.id)
                    end
                  end

                  context 'when trade pair does not have an accumulate amount' do
                    before do
                      trade_pair.update!(amount_step: 2)
                    end

                    it 'calls trade_pair.create_order with the correct amounts' do
                      order.save
                      next_quantity = order.quantity - trade_pair.amount_step
                      next_price = (order.quantity_received * (1.0 + (order.taker_fee_for_calculation * 10))) / next_quantity
                      expect(trade_pair).to have_received(:create_order).with('sell', next_price, next_quantity, order.id)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

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
          before do
            allow(order_created).to receive(:create_counter)
            order_created.trade_pair.update!(symbol: 'bnbeth')
          end

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

            # context 'when order status is not canceled' do
            #   before { order_created.update!(reference: order_id_binance_filled) }

            #   it 'does updates the order' do
            #     expect(order_created).to receive(:update!)
            #     order_created.update_from_exchange
            #   end
            # end
          end
        end
      end
    end
  end
end
