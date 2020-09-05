# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exchange, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:trade_pairs).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:name) }
  end
end
