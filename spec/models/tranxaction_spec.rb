# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tranxaction, type: :model do
  let(:client) { create(:client) }
  let(:tranxaction) { build(:tranxaction) }

  describe 'ASSOCIATIONS' do
  	it { should have_many(:tranxactables).dependent(:destroy) }
  	it { should have_many(:attachments).dependent(:destroy) }
  	it { should belong_to(:tax_category) }
  end

  # describe 'CALLBACKS' do
  # 	describe 'after_create' do
  #     context 'when tranxaction has a tranxactable with resource_type Client' do
  #       before do
  #         Tranxactable.create(resource: client, tranxaction: tranxaction)
  #       end

  #       it 'creates a Tranxactable with that tranxaction and with TranxactionType for work' do
  #         tranxaction.save!
  #         expect(Tranxactable.count).to be true
  #       end
  #     end
  # 	end
  # end
end
