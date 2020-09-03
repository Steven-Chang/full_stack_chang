# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exchange, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:crypto_exchanges).dependent(:destroy) }
    it { should have_many(:cryptos) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:name) }
  end
end
