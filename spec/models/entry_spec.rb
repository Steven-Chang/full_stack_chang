# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:aim) }
  end
end
