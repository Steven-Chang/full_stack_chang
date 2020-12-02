# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'ASSOCIATIONS' do
    it { should have_and_belong_to_many(:tools) }
    it { should have_many(:achievements).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:title) }
  end
end
