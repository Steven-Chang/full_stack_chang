# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaxCategory do
  describe 'ASSOCIATIONS' do
  	it { should have_many(:tranxactions).dependent(:restrict_with_error) }
  end

  describe 'VALIDATIONS' do
    before { create(:tax_category) }

  	it { should validate_uniqueness_of(:description).case_insensitive }
  end
end
