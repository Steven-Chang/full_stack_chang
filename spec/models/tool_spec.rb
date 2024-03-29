# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tool do
  describe 'ASSOCIATIONS' do
    it { should have_and_belong_to_many(:projects) }
    it { should have_many(:attachments_attachments) }
    it { should have_one(:logo_attachment) }
  end

  describe 'VALIDATIONS' do
    before { create(:tool) }

    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_content_type_of(:logo).allowing('image/*') }
    it { should validate_size_of(:logo).less_than(500.kilobytes) }
  end
end
