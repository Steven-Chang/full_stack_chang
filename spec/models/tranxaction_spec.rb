# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tranxaction do
  let(:client) { create(:client) }
  let(:tax_category) { create(:tax_category) }
  let(:tranxaction) { build(:tranxaction) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:tax_category).optional(true) }
    it { should belong_to(:tranxactable).optional(true) }
    it { should belong_to(:creditor).optional(true) }
    it { should belong_to(:user) }
  	it { should have_many(:attachments_attachments) }
  end

  describe 'CALLBACKS' do
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
