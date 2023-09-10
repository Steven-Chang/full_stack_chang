# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    date { Date.current }
    description { 'Achieved something today!' }

    project
  end
end
