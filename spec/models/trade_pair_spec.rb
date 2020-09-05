# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradePair, type: :model do
  let!(:trade_pair) { create(:trade_pair) }
  let(:trade_pair_without_fees) { trade_pair }
  let(:trade_pair_with_fees) { create(:trade_pair, :fees_present) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:exchange) }
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
        expect(trade_pair.trade_fee_total(0.1, 10)).to eq(1 * 0.001)
      end
    end
  end
end
