# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentSummary do
  let(:tranxaction) { create(:tranxaction) }

  describe 'ASSOCIATIONS' do
  	it { should belong_to(:client) }
  	it { should have_many(:attachments_attachments) }
    it { should have_one(:user) }
  end

  describe 'VALIDATIONS' do
    before { create(:payment_summary) }

  	it { should validate_numericality_of(:year_ending).only_integer }
  	it { should validate_uniqueness_of(:client_id).scoped_to(:year_ending) }
  end

  # describe 'INSTANCE METHODS' do
  # 	describe '#gross_payment' do
  # 		it 'returns the sum of incoming taxable tranxactions for the related financial year' do
  #       payment_summary.client.tranxactables.create(tranxaction: tranxaction)
  #       tranxaction.update(tax: false)
  # 			expect(payment_summary.gross_payment).to eq(0)
  #       tranxaction.update(tax: true)
  #       expect(payment_summary.gross_payment).to eq(tranxaction.amount)
  #       tranxaction.update(date: Date.new(payment_summary.year_ending - 3))
  #       expect(payment_summary.gross_payment).to eq(0)
  #       tranxaction.update(date: Date.new(payment_summary.year_ending))
  #       expect(payment_summary.gross_payment).to eq(tranxaction.amount)
  #       tranxaction.update(amount: -1)
  #       expect(payment_summary.gross_payment).to eq(0)
  # 		end
  # 	end

  #   describe '#total_expenses' do
  #     it 'returns the sum of outgoing taxable tranxactions for the related financial year' do
  #       payment_summary.client.tranxactables.create(tranxaction: tranxaction)
  #       tranxaction.update(amount: -1)
  #       tranxaction.update(tax: false)
  #       expect(payment_summary.total_expenses).to eq(0)
  #       tranxaction.update(tax: true)
  #       expect(payment_summary.total_expenses).to eq(tranxaction.amount)
  #       tranxaction.update(date: Date.new(payment_summary.year_ending - 3))
  #       expect(payment_summary.total_expenses).to eq(0)
  #       tranxaction.update(date: Date.new(payment_summary.year_ending))
  #       expect(payment_summary.total_expenses).to eq(tranxaction.amount)
  #       tranxaction.update(amount: 1)
  #       expect(payment_summary.total_expenses).to eq(0)
  #     end
  #   end
  # end
end
