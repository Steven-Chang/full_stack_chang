# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'ASSOCIATIONS' do
    it { should have_many(:scores).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:title) }
  end
end
