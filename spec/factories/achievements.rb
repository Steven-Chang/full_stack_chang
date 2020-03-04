# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    date { Date.current }
    description { 'Achieved something today!' }

    association :project
  end
end
