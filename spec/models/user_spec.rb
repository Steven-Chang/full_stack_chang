# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { build(:user) }

	# === ASSOCIATIONS ===
	it { should have_many(:tenancy_agreements).dependent(:restrict_with_error) }
	it { should have_many(:tranxactables).dependent(:restrict_with_error) }
	it { should have_many(:tranxactions) }

	# === INSTANCE METHODS ===
	describe '#admin?' do
		it 'returns true if user has email prime_pork@hotmail.com' do
			user.email = 'prime_pork@hotmail.com'
			expect(user.admin?).to be true
		end

		it 'returns true if user has email stevenchang5000@gmail.com' do
			user.email = 'stevenchang5000@gmail.com'
			expect(user.admin?).to be true
		end

		it 'returns false if user does not have email prime_pork@hotmail.com or stevenchang5000@gmail.com' do
			user.email = 'not_prime_pork@hotmail.com'
			expect(user.admin?).to be false
		end
	end
end
