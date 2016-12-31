# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Crypto do
  describe 'VALIDATIONS' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:name) }
  end

  describe 'CALLBACKS' do
    describe 'before_save' do
      it 'downcases the identifier' do
        crypto = build(:crypto, identifier: 'BTC')
        crypto.save
        expect(crypto.identifier).to eq('btc')
      end
    end
  end
end
