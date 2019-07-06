# frozen_string_literal: true

FactoryBot.define do
  factory :aim do
    sequence(:description) { |n| "aim-#{n}" }
  end

  factory :blog_post do
    title { 'Blog post title' }
  end

  factory :client do
    sequence(:name) { |n| "client #{n}" }
  end

  factory :payment_summary do
    year_ending { Date.current.month < 7 ? Date.current.year : Date.current.year + 1 }

    association :client
  end

  factory :project do
    title { 'Project title' }
  end

  factory :tranxaction do
    date { Date.current }
    sequence(:description) { |n| "Tranxaction description #{n}" }
    amount { rand(1..100) }
    tax { true }
  end

  factory :user do
    sequence(:email) { |n| "stevenchang#{n}@gmail.com" }
    password { 'spamandedggs' }
  end
end
