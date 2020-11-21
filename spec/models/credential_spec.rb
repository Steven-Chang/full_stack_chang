# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Credential, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to :exchange }
    it { should have_many(:trade_pairs).dependent(:restrict_with_exception) }
  end
end
