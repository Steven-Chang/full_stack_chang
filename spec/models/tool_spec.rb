# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tool, type: :model do
  let!(:tool) { create(:tool) }

  describe 'ASSOCIATIONS' do
    it { should have_and_belong_to_many(:projects) }
    it { should have_many(:attachments).dependent(:destroy).inverse_of(:resource) }
  end

  describe 'VALIDATIONS' do
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
