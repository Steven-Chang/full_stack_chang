# frozen_string_literal: true

FactoryBot.define do
  factory :creditor do
  	sequence(:name) { |n| "creditor-#{n}" }
  end
end
