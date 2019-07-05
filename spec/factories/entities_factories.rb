# frozen_string_literal: true

FactoryBot.define do
  factory :aim do
    sequence(:description) { |n| "aim-#{n}" }
  end

  factory :blog_post do
    title { 'Blog post title' }
  end

  factory :project do
    title { 'Project title' }
  end

  factory :user do
    sequence(:email) { |n| "stevenchang#{n}@gmail.com" }
    password { 'spamandedggs' }
  end
end
