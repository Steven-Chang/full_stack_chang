# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchange, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:crypto) }
    it { should belong_to(:exchange) }
  end
end
