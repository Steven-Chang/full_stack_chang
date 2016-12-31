# frozen_string_literal: true

class Tranxaction < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :creditor, optional: true
  belongs_to :tax_category, optional: true
  belongs_to :tranxactable, polymorphic: true, optional: true
  has_many :attachments, as: :resource, dependent: :destroy

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true

  # === VALIDATIONS ===
  validates :date, :description, :amount, presence: true

  # === CALLBACKS ===
  before_save do |tranxaction|
    tranxaction.tax_category_id = nil unless tranxaction.tax
  end

  # === CLASS METHODS ===
  def self.balance(tranxactable = nil, from = nil, to = nil, greater_than = nil, less_than = nil, tax = 'ignore')
    filter(tranxactable, from, to, greater_than, less_than, tax).sum(:amount)
  end

  def self.filter(tranxactable = nil, from = nil, to = nil, greater_than = nil, less_than = nil, tax = 'ignore')
    tranxactions = tranxactable ? tranxactable.tranxactions : Tranxaction.all
    tranxactions = tranxactions.where('date >= ?', from) if from
    tranxactions = tranxactions.where('date <= ?', to) if to
    tranxactions = tranxactions.where('amount > ?', greater_than) if greater_than
    tranxactions = tranxactions.where('amount < ?', less_than) if less_than
    tranxactions.where(tax:) unless tax == 'ignore'
  end

  def self.end_of_financial_year_dates_ordered_descending_for_dashboard
    tax_tranxactions_ordered_by_date = Tranxaction.where(tax: true).order(:date)
    return if tax_tranxactions_ordered_by_date.empty?

    earliest_tranxaction_date = tax_tranxactions_ordered_by_date.first.date
    latest_tranxaction_date = tax_tranxactions_ordered_by_date.last.date
    latest_end_of_financial_year_date = Date.new(latest_tranxaction_date.year + (latest_tranxaction_date.month > 6 ? 1 : 0), 6, 30)
    earliest_end_of_financial_year_date = Date.new(earliest_tranxaction_date.year + (earliest_tranxaction_date.month > 6 ? 1 : 0), 6, 30)
    dates = [latest_end_of_financial_year_date]
    dates.push(dates.last - 1.year) while dates.last >= earliest_end_of_financial_year_date
    dates
  end

  def self.tranxactables_with_tranxactions(tranxactable_type, from = nil, to = nil, tax = 'ignore')
    tranxactable_ids = Tranxaction.filter(nil, from, to, nil, nil, tax)
                                  .where(tranxactable_type:)
                                  .pluck(:tranxactable_id)
                                  .uniq
    tranxactable_type.constantize.where(id: tranxactable_ids)
  end
end
