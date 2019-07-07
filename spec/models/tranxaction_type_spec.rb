# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TranxactionType, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:tranxactables).dependent(:destroy) }
    it { should have_many(:tranxactions) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:description) }
  end
end
