# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Line, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:score) }
  end
end
