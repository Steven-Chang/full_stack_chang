# frozen_string_literal: true

FactoryBot.define do
  factory :blog_post do
    date_added { Date.current }
    description { 'Blog post description' }
    title { 'Blog post title' }
  end

  factory :client do
    sequence(:name) { |n| "client #{n}" }

    user
  end

  factory :creditor do
    sequence(:name) { |n| "creditor-#{n}" }

    user
  end

  factory :payment_summary do
    year_ending { Date.current.month < 7 ? Date.current.year : Date.current.year + 1 }

    client
  end

  factory :tax_category do
    sequence(:description) { |n| "tax category #{n}" }
  end

  factory :tool do
    sequence(:name) { |n| "tool #{n}" }
    category { Tool.categories.keys.first }
  end

  factory :tranxaction do
    date { Date.current }
    sequence(:description) { |n| "Tranxaction description #{n}" }
    amount { rand(1..100) }
    tax { true }

    user
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    password { 'spamandedggs' }
  end
end
