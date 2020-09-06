# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exchange, type: :model do
  let(:default_exchange) { create }

  describe 'ASSOCIATIONS' do
    it { should have_many(:trade_pairs).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:name) }
  end

  describe 'CLASS METHODS' do
    describe '.create_default_exchanges' do
      context 'when default exchange already exists' do
        before { create(:exchange, identifier: Exchange::DEFAULT_EXCHANGES.keys.first) }

        it 'does not re-create the default_exchange' do
          expect(Exchange.where(identifier: 'coinspot').count).to be 1
          Exchange.create_default_exchanges
          expect(Exchange.where(identifier: 'coinspot').count).to be 1
        end
      end

      context 'when default exchange does not exist' do
        it 'creates the default exchanges' do
          expect(Exchange.count).to be 0
          Exchange.create_default_exchanges
          expect(Exchange.count).to be Exchange::DEFAULT_EXCHANGES.keys.count
          expect(Exchange.first.identifier).to eq(Exchange::DEFAULT_EXCHANGES.first.first.to_s)
          expect(Exchange.first.name).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:name])
          expect(Exchange.first.url).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:url])
          expect(Exchange.first.maker_fee).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:maker_fee])
          expect(Exchange.first.taker_fee).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:taker_fee])
        end
      end
    end
  end
end
