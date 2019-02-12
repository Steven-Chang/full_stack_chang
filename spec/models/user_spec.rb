# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:per_page) { 12 }
  let(:number_of_public_posts) { per_page / 2 }
  let(:number_of_private_posts) { per_page / 2 }
  let(:prime_pork_user) { create(:user, email: 'prime_pork@hotmail.com') }
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe '#is_the_boss_man?' do
    it 'returns false if the email of user is not prime_pork@hotmail.com' do
      expect(user.the_boss_man?).to eq(false)
    end

    it 'returns true if the email of user is prime_pork@thotmail.com' do
      expect(prime_pork_user.the_boss_man?).to eq(true)
    end
  end
end
