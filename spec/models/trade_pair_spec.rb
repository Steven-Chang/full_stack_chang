# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradePair, type: :model do
  let(:order) { create(:order, :open, :sell, trade_pair_id: trade_pair.id) }
  let(:order_two) { create(:order, :open, :sell, trade_pair_id: trade_pair.id) }
  let!(:trade_pair) { create(:trade_pair) }
  let(:trade_pair_without_fees) { trade_pair }
  let(:trade_pair_with_fees) { create(:trade_pair, :fees_present) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:credential).optional }
    it { should have_one(:exchange) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe 'ENUMERATORS' do
    it { should define_enum_for(:market_type).with_values(spot: 0, margin_cross: 1, margin_isolated: 2) }
    it { should define_enum_for(:mode).with_values(accumulate: 0, buy: 1, sell: 2, counter_only: 3) }
  end

  describe 'DELEGATES' do
    it { should delegate_method(:client).to(:credential) }
  end

  describe 'VALIDATIONS' do
    describe ':open_orders_limit' do
      it { should validate_numericality_of(:open_orders_limit).allow_nil }

      describe '#open_orders_limit_validation' do
        context 'when trade_pair does not have an open_orders_limit' do
          before { trade_pair.open_orders_limit = nil }

          it 'is valid' do
            expect(trade_pair.valid?).to be true
          end
        end

        context 'when trade_pair has an open_orders_limit' do
          before { trade_pair.open_orders_limit = 100 }

          context "when trade_pair's exchange does not have an open order limit per trade pair" do
            before { trade_pair.exchange.update(open_orders_limit_per_trade_pair: nil) }

            it 'is valid' do
              expect(trade_pair.valid?).to be true
            end
          end

          context "when trade_pair's exchange has an open order limit per trade pair" do
            before { trade_pair.exchange.update(open_orders_limit_per_trade_pair: 100) }

            context "when trade_pair's open_orders_limit is less than or equal to exchange's open_orders_limit_per_trade_pair" do
              before { trade_pair.open_orders_limit = trade_pair.exchange.open_orders_limit_per_trade_pair }

              it 'is valid' do
                expect(trade_pair.valid?).to be true
              end
            end

            context "when trade_pair's open_orders_limit is less than or equal to exchange's open_orders_limit_per_trade_pair" do
              before { trade_pair.open_orders_limit = trade_pair.exchange.open_orders_limit_per_trade_pair + 1 }

              it 'is valid' do
                expect(trade_pair.valid?).to be false
              end
            end
          end
        end
      end
    end
    it { should validate_numericality_of(:accumulate_time_limit_in_seconds).is_greater_than_or_equal_to(TradePair::MAX_TRADE_FREQUENCY_IN_SECONDS) }
    it { should validate_presence_of(:symbol) }
    it { should validate_uniqueness_of(:symbol).scoped_to(:credential_id).case_insensitive }
    it { should validate_numericality_of(:percentage_from_market_price_buy_minimum).is_greater_than_or_equal_to(0.01).is_less_than_or_equal_to(100).allow_nil }
    it { should validate_numericality_of(:percentage_from_market_price_buy_maximum).is_greater_than_or_equal_to(0.01).is_less_than_or_equal_to(100).allow_nil }

    context 'when enabled' do
      before { allow(subject).to receive(:enabled).and_return(true) }

      it { should validate_presence_of(:amount_step) }
      it { should validate_presence_of(:minimum_total) }
      it { should validate_presence_of(:price_precision) }
    end
  end

  describe 'CALLBACKS' do
    describe 'before_save' do
      it 'downcases the symbol' do
        trade_pair = build(:trade_pair, symbol: 'BTCAUD')
        trade_pair.save
        expect(trade_pair.symbol).to eq('btcaud')
      end
    end
  end

  describe 'INSTANCE METHODS' do
    # Needs refactoring to handle different limits
    # describe '#accumulate' do
    #   context 'when not enabled' do
    #     before { trade_pair.update!(enabled: false) }

    #     it 'does not call #create_order' do
    #       expect(trade_pair).not_to receive(:create_order)
    #     end
    #   end

    #   context 'when enabled' do
    #     before { trade_pair.update!(enabled: true) }

    #     context 'when trade pair has one open orders' do
    #       before { order }

    #       it 'updates order from exchange' do
    #         expect_any_instance_of(Order).to receive(:update_from_exchange)
    #         expect_any_instance_of(Order).to receive(:reload)
    #         expect_any_instance_of(Order).not_to receive(:create_counter)
    #         trade_pair.accumulate
    #       end

    #       context 'when order is filled' do
    #         before do
    #           allow_any_instance_of(Order).to receive(:update_from_exchange)
    #           allow_any_instance_of(Order).to receive(:reload)
    #           allow_any_instance_of(Order).to receive(:filled?).and_return(true)
    #         end

    #         it 'creates a counter order if order is filled' do
    #           expect_any_instance_of(Order).to receive(:create_counter)
    #           trade_pair.accumulate
    #         end
    #       end

    #       context 'when order is not filled' do
    #         before do
    #           allow_any_instance_of(Order).to receive(:update_from_exchange)
    #           allow_any_instance_of(Order).to receive(:reload)
    #           allow_any_instance_of(Order).to receive(:filled?).and_return(false)
    #         end

    #         context 'when order is a buy order' do
    #           context 'when order was created in the last 3 hours' do
    #             it 'does not create an order' do
    #               expect(trade_pair.orders.where(status: 'open', buy_or_sell: 'sell').count).to be 1
    #               expect(trade_pair).not_to receive(:create_order)
    #               trade_pair.accumulate
    #             end
    #           end

    #           context 'when order was created more than 1 hour ago' do
    #             it 'creates an order' do
    #               allow(trade_pair).to receive(:get_open_orders).with('buy').and_return([{}, {}, { rate: 33 }])
    #               next_price = 33.to_d
    #               base_total = trade_pair.minimum_total * 2
    #               expect(trade_pair).not_to receive(:create_order).with('buy', next_price, base_total)
    #               trade_pair.accumulate
    #             end
    #           end
    #         end
    #       end
    #     end

    #     context 'when trade pair has two buy orders' do
    #       before do
    #         order
    #         order_two
    #         allow_any_instance_of(Order).to receive(:update_from_exchange)
    #         allow_any_instance_of(Order).to receive(:reload)
    #         allow_any_instance_of(Order).to receive(:filled?).and_return(false)
    #       end

    #       it 'does not call #create_order' do
    #         expect(trade_pair.orders.where(status: 'open', buy_or_sell: 'sell').count).to be 2
    #         expect(trade_pair).not_to receive(:create_order)
    #         trade_pair.accumulate
    #       end
    #     end
    #   end
    # end

    describe '#trade_fee_general' do
      context 'when crypto_exchange has specific fees' do
        it 'returns the fee for the specific pair' do
          expect(trade_pair_with_fees.trade_fee_general('maker')).to eq(trade_pair_with_fees.maker_fee)
          expect(trade_pair_with_fees.trade_fee_general('taker')).to eq(trade_pair_with_fees.taker_fee)
        end
      end

      context 'when specific fees do not exist' do
        it 'returns the general fees from the exchange' do
          expect(trade_pair_without_fees.trade_fee_general('maker')).to eq(trade_pair_without_fees.exchange.maker_fee)
          expect(trade_pair_without_fees.trade_fee_general('taker')).to eq(trade_pair_without_fees.exchange.taker_fee)
        end
      end
    end

    describe '#trade_fee_total' do
      it 'calls #trade_fee_general' do
        expect(trade_pair).to receive(:trade_fee_total)
        trade_pair.trade_fee_total(0.1, 1400)
      end

      it 'calculates the total trade fee' do
        expect(trade_pair.trade_fee_total(0.1, 10)).to eq(0.1 * 10 * trade_pair.trade_fee_general('maker') / 100)
      end
    end

    describe '#trade_total' do
      let(:rate) { 0.1 }
      let(:quantity) { 0.1 }

      context 'when making a purchase' do
        let(:maker_or_taker) { 'maker' }

        it 'calculates the correct trade_total' do
          expect(trade_pair.trade_total(quantity, rate, maker_or_taker)).to eq(quantity * rate + trade_pair.trade_fee_total(quantity, rate, maker_or_taker))
        end
      end

      context 'when making a sale' do
        let(:maker_or_taker) { 'taker' }

        it 'calculates the correct trade_total' do
          expect(trade_pair.trade_total(quantity, rate, maker_or_taker)).to eq(quantity * rate - trade_pair.trade_fee_total(quantity, rate, maker_or_taker))
        end
      end
    end
  end
end
