# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exchange do
  let(:default_exchange) { create }

  describe 'ASSOCIATIONS' do
    it { should have_many(:trade_pairs) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:name) }
  end

  describe 'CLASS METHODS' do
    describe '.create_default_exchanges' do
      context 'when default exchange does not exist' do
        before { described_class.create_default_exchanges }

        it 'creates the default exchanges' do
          expect(described_class.count).to be Exchange::DEFAULT_EXCHANGES.keys.count
        end

        it 'sets the attributes' do
          expect(described_class.first.identifier).to eq(Exchange::DEFAULT_EXCHANGES.first.first.to_s)
          expect(described_class.first.name).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:name])
          expect(described_class.first.url).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:url])
          expect(described_class.first.maker_fee).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:maker_fee])
          expect(described_class.first.taker_fee).to eq(Exchange::DEFAULT_EXCHANGES.first.second[:taker_fee])
        end
      end
    end
  end
end
