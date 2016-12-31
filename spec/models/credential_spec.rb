# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Credential, type: :model do
  let(:trade_pair) { create(:trade_pair) }

  describe 'ASSOCIATIONS' do
    it { should belong_to :exchange }
    it { should have_many(:trade_pairs).dependent(:restrict_with_exception) }
    it { should have_many(:orders).through(:trade_pairs) }
  end
end
