# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    start_date { Date.current }
    title { 'Project title' }
  end
end
