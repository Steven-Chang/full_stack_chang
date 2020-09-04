# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchange, type: :model do
  let(:crypto_exchange) { create(:crypto_exchange) }
  let(:crypto_exchange_without_fees) { crypto_exchange }
  let(:crypto_exchange_with_fees) { create(:crypto_exchange, :fees_present) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:crypto) }
    it { should belong_to(:exchange) }
  end

  describe 'INSTANCE METHODS' do
    describe '#trade_fee_general' do
      context 'when crypto_exchange has specific fees' do
        it 'returns the fee for the specific pair' do
          expect(crypto_exchange_with_fees.trade_fee_general('maker')).to eq(crypto_exchange_with_fees.maker_fee)
          expect(crypto_exchange_with_fees.trade_fee_general('taker')).to eq(crypto_exchange_with_fees.taker_fee)
        end
      end

      context 'when specific fees do not exist' do
        it 'returns the general fees from the exchange' do
          expect(crypto_exchange_without_fees.trade_fee_general('maker')).to eq(crypto_exchange_without_fees.exchange.maker_fee)
          expect(crypto_exchange_without_fees.trade_fee_general('taker')).to eq(crypto_exchange_without_fees.exchange.taker_fee)  
        end
      end
    end

    describe '#trade_fee_total' do
      it 'calls #trade_fee_general' do
        expect(crypto_exchange.trade_fee_total(0.1, 100)).to eq(1 * 0.001)
      end
    end
  end
end
