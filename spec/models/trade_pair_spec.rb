# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradePair, type: :model do
  let!(:trade_pair) { create(:trade_pair) }
  let(:trade_pair_without_fees) { trade_pair }
  let(:trade_pair_with_fees) { create(:trade_pair, :fees_present) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:exchange) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:symbol) }
    it { should validate_uniqueness_of(:symbol).scoped_to(:exchange_id).case_insensitive }
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
          expect(trade_pair.trade_total(quantity, rate, maker_or_taker)).to eq (quantity * rate + trade_pair.trade_fee_total(quantity, rate, maker_or_taker))
        end
      end

      context 'when making a sale' do
        let(:maker_or_taker) { 'taker' }

        it 'calculates the correct trade_total' do
          expect(trade_pair.trade_total(quantity, rate, maker_or_taker)).to eq (quantity * rate - trade_pair.trade_fee_total(quantity, rate, maker_or_taker))
        end
      end
    end
  end
end
