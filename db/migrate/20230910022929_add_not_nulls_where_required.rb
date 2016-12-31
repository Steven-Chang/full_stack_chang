class AddNotNullsWhereRequired < ActiveRecord::Migration[7.0]
  def change
    change_column :tenancy_agreements, :property_id, :bigint, null: false

    change_column :scheduled_tranxaction_templates, :creditor_id, :bigint, null: false
    change_column :scheduled_tranxaction_templates, :days_for_recurrence, :integer, null: false

    change_column :projects, :start_date, :date, null: false

    change_column :orders, :price, :decimal, null: false
    change_column :orders, :quantity, :decimal, null: false
    change_column :orders, :trade_pair_id, :bigint, null: false

    change_column :credentials, :exchange_id, :bigint, null: false

    change_column :blog_posts, :date_added, :datetime, null: false
  end
end
