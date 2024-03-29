# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenancyAgreement do
  describe 'ASSOCIATIONS' do
  	it { should belong_to(:user) }
  	it { should belong_to(:property) }
  	it { should have_many(:tranxactions).dependent(:restrict_with_exception) }
  end

  describe 'VALIDATIONS' do
  	it { should validate_numericality_of(:amount) }
  	it { should validate_numericality_of(:bond).allow_nil }
  	it { should validate_presence_of(:starting_date) }
  end
end
