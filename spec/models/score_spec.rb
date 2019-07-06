# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'ASSOCIATIONS' do
  	it { should belong_to(:project) }
  end

  describe 'VALIDATIONS' do
  	it { should validate_presence_of(:name) }
  	it { should validate_numericality_of(:score).only_integer }
  	it { should validate_numericality_of(:level).allow_nil.only_integer }
  	it { should validate_numericality_of(:lines).allow_nil.only_integer }
  end
end
