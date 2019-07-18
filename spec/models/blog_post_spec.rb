# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:attachments).dependent(:destroy).inverse_of(:resource) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:date_added) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:title) }
  end
end
