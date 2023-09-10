# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Creditor do
	describe 'ASSOCIATIONS' do
		it { should have_many(:tranxactions).dependent(:restrict_with_error) }
	end

	describe 'VALIDATIONS' do
		before { create(:creditor) }

		it { should validate_uniqueness_of(:name).case_insensitive }
	end
end
