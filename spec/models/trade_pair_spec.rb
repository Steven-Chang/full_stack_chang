# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradePair, type: :model do
  let!(:trade_pair) { create(:trade_pair) }

  describe 'ASSOCIATIONS' do    describe 'ASSOCIATIONS' do
    it { should belong_to(:exchange) }
  end   end

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
end
