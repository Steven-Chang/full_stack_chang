# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:trade_pair) }
  end

  describe 'VALIDATIONS' do
    it { should validate_inclusion_of(:buy_or_sell).in_array(%w[buy sell]) }
    it { should validate_inclusion_of(:status).in_array(%w[open filled]) }
  end
end
