# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tranxactable, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:tranxaction) }
    it { should belong_to(:resource) }
  end
end
