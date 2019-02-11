FactoryBot.define do
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

  # factory :baddie_status do
  #   description { 'pending' }

  #   trait :pending do
  #     description { 'pending' }
  #   end
  # end

  # factory :baddie_user do
  #   sequence(:email) { |n| "stevenchang#{n}@gmail.com" }
  #   sequence(:nickname) { |n| "jordanschlansky#{n}" }
  #   password { 'spamandeggs' }
  #   snapchat_account { 'jordanschlansky' }

  #   association :baddie_status

  #   after(:create) do |baddie_user, evaluator|
  #     create :subscription_option, :feed, baddie_user: baddie_user
  #     create :subscription_option, :snapchat_monthly, baddie_user: baddie_user
  #     create :subscription_option, :snapchat_life_time, baddie_user: baddie_user
  #     create :subscription_option, :snapchat_custom_video, baddie_user: baddie_user
  #   end

  #   factory :baddie_user_with_posts do
  #     # posts_count is declared as a transient attribute and available in
  #     # attributes on the factory, as well as the callback via the evaluator
  #     transient do
  #       posts_count { 5 }
  #     end

  #     # the after(:create) yields two values; the user instance itself and the
  #     # evaluator, which stores all values from the factory, including transient
  #     # attributes; `create_list`'s second argument is the number of records
  #     # to create and we make sure the user is associated properly to the post
  #     after(:create) do |baddie_user, evaluator|
  #       create_list(:post, evaluator.posts_count, baddie_user: baddie_user)
  #     end
  #   end
  # end

  # factory :post do
  #   body { 'Post body' }
  #   title { 'Post title' }

  #   association :baddie_user
  # end

  # factory :subscription_option do
  #   active { true }
  #   price { 29.99 }

  #   association :baddie_user
  #   association :subscription_type, :feed

  #   trait :feed do
  #     association :subscription_type, :feed
  #   end

  #   trait :snapchat_monthly do
  #     association :subscription_type, :snapchat_monthly
  #   end

  #   trait :snapchat_life_time do
  #     association :subscription_type, :snapchat_life_time
  #   end

  #   trait :snapchat_custom_video do
  #     association :subscription_type, :snapchat_custom_video
  #   end
  # end

  # factory :subscription_type do
  #   deprecated { false }
  #   description { 'monthly' }

  #   trait :feed do
  #     description { 'monthly' }
  #     days { 30 }
  #     category { 'feed' }
  #   end

  #   trait :snapchat_monthly do 
  #     description { 'monthly' }
  #     days { 30 }
  #     category { 'snapchat' }
  #   end

  #   trait :snapchat_life_time do
  #     description { 'one year, one time fee' }
  #     category { 'snapchat' }
  #   end

  #   trait :snapchat_custom_video do
  #     description { 'monthly' }
  #     category { 'feed' }
  #     deprecated { true }
  #   end
  # end

  # factory :user do
  #   sequence(:email) { |n| "stevenchang#{n}@gmail.com" }
  #   sequence(:username) { |n| "jordanschlansky#{n}" }
  #   password { 'spamandeggs' }
  #   snapchat_account { 'jordanschlansky' }

  #   association :user_type
  # end

  # factory :user_type do
  #   name { 'user' }
  # end

  # factory :company, class: Company do
  #   sequence(:id) { |n| "comp-#{n}" }
  #   sequence(:channel_id) { |n| "org-#{n}" }
  #   sequence(:name) { |n| "org-#{n}" }
  #   currency 'AUD'
  #   financial_year_end_month 6
  #   is_primary true

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :contact, class: Contact do
  #   sequence(:id) { |n| "cont-#{n}" }
  #   sequence(:name) { |n| "Contact-#{n}" }
  #   is_primary true
  #   reference { |n| "ref-#{n}" }

  #   association(:company, factory: :company)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :account, class: Account do
  #   sequence(:id) { |n| "acc-#{n.to_s.rjust(3, '0')}" }
  #   sequence(:name) { |n| "Account-#{n.to_s.rjust(3, '0')}" }
  #   currency 'AUD'
  #   is_primary true

  #   association(:company, factory: :company)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :invoice, class: Invoice do
  #   sequence(:title) { |n| "Invoice-#{n}" }
  #   sequence(:transaction_number) { |n| "trx-#{n}" }
  #   status 'AUTHORISED'
  #   is_primary true
  #   amount 100
  #   due_date Time.zone.now

  #   association(:contact, factory: :contact)
  #   association(:company, factory: :company)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :bill, class: Bill do
  #   sequence(:title) { |n| "Bill-#{n}" }
  #   sequence(:transaction_number) { |n| "trxb-#{n}" }
  #   status 'AUTHORISED'
  #   is_primary true
  #   amount 100
  #   due_date Time.zone.now

  #   association(:contact, factory: :contact)
  #   association(:company, factory: :company)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :credit_bank_transaction, class: CreditBankTransaction do
  #   sequence(:title) { |n| "BankTrans-#{n}" }
  #   status 'AUTHORISED'
  #   is_primary true
  #   amount 100
  #   transaction_date Time.zone.now

  #   association(:contact, factory: :contact)
  #   association(:company, factory: :company)
  #   association(:account, factory: :account)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :debit_bank_transaction, class: DebitBankTransaction do
  #   sequence(:title) { |n| "BankTrans-#{n}" }
  #   status 'AUTHORISED'
  #   is_primary true
  #   amount 100
  #   transaction_date Time.zone.now

  #   association(:contact, factory: :contact)
  #   association(:company, factory: :company)
  #   association(:account, factory: :account)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :journal, class: Journal do
  #   sequence(:id) { |n| "bil-#{n}" }
  #   is_primary true

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :journal_line, class: JournalLine do
  #   sequence(:id) { |n| "bil-#{n}" }

  #   association(:account, factory: :account)
  #   association(:journal, factory: :journal)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :sales_order, class: SalesOrder do
  #   sequence(:id) { |n| "sales-order-#{n}" }
  #   is_primary true

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :sales_order_line, class: SalesOrderLine do
  #   sequence(:id) { |n| "sales-order-line-#{n}" }
  #   is_primary true

  #   association(:account, factory: :account)
  #   association(:sales_order, factory: :sales_order)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :time_activity, class: TimeActivity do
  #   sequence(:id) { |n| "ta-#{n}" }
  #   is_primary true

  #   association(:company, factory: :company)

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :user, class: User do
  #   email 'john@doe.com'
  #   first_name 'John'
  #   last_name 'Doe'
  # end

  # factory :trend, class: Trend do
  #   association(:user, factory: :user)
  #   association(:trends_group, factory: :trends_group)

  #   name 'My trend'
  #   period 'weekly'
  #   rate 2
  #   start_date Time.zone.now

  #   trait :with_timestamps do
  #     created_at Time.zone.now
  #     updated_at Time.zone.now
  #   end
  # end

  # factory :trends_group, class: TrendsGroup do
  #   association(:company, factory: :company)

  #   name 'My group'
  # end

  # factory :balance_change do
  #   association :company
  #   transaction_reference { |a| a.association(:invoice, { company: a.company }.compact) }
  #   currency 'AUD'
  #   balance_before 100.0
  #   balance_after 50.0
  # end
end