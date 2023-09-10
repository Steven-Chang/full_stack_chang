# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property do
  describe 'ASSOCIATIONS' do
  	it { should have_many(:tax_categories) }
  	it { should have_many(:tenancy_agreements).dependent(:restrict_with_error) }
  	it { should have_many(:tranxactions) }
  end

  describe 'VALIDATIONS' do
  	it { should validate_presence_of(:address) }
  end
end
