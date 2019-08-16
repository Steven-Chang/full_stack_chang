# frozen_string_literal: true

class Tranxaction < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :creditor
  belongs_to :tax_category
  belongs_to :tranxactable, polymorphic: true
  has_many :attachments, as: :resource, dependent: :destroy

  # === ACCEPTS_NESTED_ATTRIBUTES_FOR ===
  accepts_nested_attributes_for :attachments, allow_destroy: true

  # === CALLBACKS ===
  before_save do |tranxaction|
    tranxaction.tax_category_id = nil unless tranxaction.tax
  end

  # === CLASS METHODS ===
  def self.balance(tranxactable = nil, from = nil, to = nil, greater_than = nil, less_than = nil, tax = 'ignore')
    tranxactions = filter(tranxactable, from, to, greater_than, less_than, tax)
    tranxactions.sum(:amount)
  end

  def self.filter(tranxactable = nil, from = nil, to = nil, greater_than = nil, less_than = nil, tax = 'ignore')
    tranxactions = tranxactable ? tranxactable.tranxactions : Tranxaction.all
    tranxactions = tranxactions.where('date >= ?', from) if from
    tranxactions = tranxactions.where('date <= ?', to) if to
    tranxactions = tranxactions.where('amount > ?', greater_than) unless greater_than.nil?
    tranxactions = tranxactions.where('amount < ?', less_than) unless less_than.nil?
    tranxactions.where(tax: tax) unless tax == 'ignore'
  end

  def self.end_of_financial_year_dates_ordered_descending_for_dashboard
    tax_tranxactions_ordered_by_date = Tranxaction.where(tax: true)
                                                  .order(:date)
    return if tax_tranxactions_ordered_by_date.empty?

    earliest_tranxaction_date = tax_tranxactions_ordered_by_date.first.date
    latest_tranxaction_date = tax_tranxactions_ordered_by_date.last.date
    latest_end_of_financial_year_date = Date.new(latest_tranxaction_date.year + (latest_tranxaction_date.month > 6 ? 1 : 0), 6, 30)
    earliest_end_of_financial_year_date = Date.new(earliest_tranxaction_date.year + (earliest_tranxaction_date.month > 6 ? 1 : 0), 6, 30)
    dates = [latest_end_of_financial_year_date]
    dates.push(dates.last - 1.year) while dates.last >= earliest_end_of_financial_year_date
    dates
  end
end
