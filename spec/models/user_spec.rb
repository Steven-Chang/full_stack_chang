# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { build(:user) }

	# === ASSOCIATIONS ===
	it { should have_many(:tenancy_agreements).dependent(:restrict_with_error) }
	it { should have_many(:tranxactions) }
end
