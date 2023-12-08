# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:user) }
    it { should have_many(:payment_summaries).dependent(:destroy) }
    it { should have_many(:tranxactions).dependent(:restrict_with_exception) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:name) }
  end
end
