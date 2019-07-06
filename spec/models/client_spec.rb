# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:payment_summaries).dependent(:destroy) }
    it { should have_many(:tranxactables).dependent(:destroy) }
    it { should have_many(:tranxactions).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:name) }
  end
end
