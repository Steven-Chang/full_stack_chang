# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tranxaction, type: :model do
  let(:client) { create(:client) }
  let(:tax_category) { create(:tax_category) }
  let(:tranxaction) { build(:tranxaction) }

  describe 'ACCEPTS NESTED ATTRIBUTES FOR' do
    it { should accept_nested_attributes_for(:attachments) }
  end

  describe 'ASSOCIATIONS' do
    it { should belong_to(:tax_category) }
    it { should belong_to(:tranxactable) }
    it { should belong_to(:creditor) }
  	it { should have_many(:tranxactables).dependent(:destroy) }
  	it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'CALLBACKS' do
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
    describe 'before_save' do
      context 'when tranxaction has a tax_category' do
        before do
          tranxaction.tax_category = tax_category
        end

        context 'when tranxaction.tax is true' do
          it 'does not clear the tax category on save' do
            tranxaction.save!
            expect(tranxaction.tax_category.present?).to be true
          end
        end

        context 'when tranxaction.tax is false' do
          before do
            tranxaction.tax = false
          end

          it 'clears the tax category on save' do
            tranxaction.save!
            expect(tranxaction.tax_category.present?).to be false
          end
        end
      end
    end
  end
end
