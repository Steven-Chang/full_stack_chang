# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduledTranxactionTemplate do
  describe 'ASSOCIATIONS' do
    it { should belong_to(:tax_category).optional(true) }
    it { should belong_to(:tranxactable) }
    it { should belong_to(:creditor) }
  end

  describe 'VALIDATIONS' do
    it { should validate_numericality_of(:amount) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:days_for_recurrence) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:tranxactable_type) }
  end
end
