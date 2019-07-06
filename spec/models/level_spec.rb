# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Level, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:score) }
  end
end
