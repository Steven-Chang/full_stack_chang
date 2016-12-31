# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:project) }
  end
end
