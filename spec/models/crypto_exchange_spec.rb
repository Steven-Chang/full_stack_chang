# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchange, type: :model do
  let!(:crypto_exchange) { create(:crypto_exchange) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:crypto) }
    it { should belong_to(:exchange) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:symbol) }
    it { should validate_uniqueness_of(:symbol).scoped_to(:exchange_id).case_insensitive }
  end

  describe 'CALLBACKS' do
    describe 'before_save' do
      it 'downcases the symbol' do
        crypto_exchange = build(:crypto_exchange, symbol: 'BTCAUD')
        crypto_exchange.save
        expect(crypto_exchange.symbol).to eq('btcaud')
      end
    end
  end
end
