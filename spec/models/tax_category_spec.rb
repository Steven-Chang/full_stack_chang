# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaxCategory, type: :model do
	let!(:tax_category) { create(:tax_category) }

  describe 'ASSOCIATIONS' do
  	it { should have_many(:tranxactions).dependent(:restrict_with_error) }
  end

  describe 'VALIDATIONS' do
  	it { should validate_uniqueness_of(:description).case_insensitive }
  end
end
