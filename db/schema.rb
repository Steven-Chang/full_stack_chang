# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_08_061852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "fsc_achievements", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "fsc_ind_achievements_on_project_id"
  end

  create_table "fsc_attachments", force: :cascade do |t|
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "file_type", default: 1
    t.string "cloudinary_public_id"
    t.index ["resource_id", "resource_type"], name: "index_fsc_attachments_on_resource_id_and_resource_type"
  end

  create_table "fsc_blog_posts", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "title", null: false
    t.datetime "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "private", default: true
  end

  create_table "fsc_clients", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fsc_credentials", force: :cascade do |t|
    t.string "identifier", null: false
    t.bigint "exchange_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "enabled", default: true
    t.index ["exchange_id"], name: "fsc_ind_credentials_on_exchange_id"
  end

  create_table "fsc_creditors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "fsc_ind_creditors_on_name", unique: true
  end

  create_table "fsc_crypto_exchanges", force: :cascade do |t|
    t.bigint "crypto_id"
    t.bigint "exchange_id"
    t.decimal "withdrawal_fee", precision: 8, scale: 6
    t.decimal "maker_fee", precision: 8, scale: 6
    t.decimal "taker_fee", precision: 8, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crypto_id"], name: "fsc_ind_crypto_exchanges_on_crypto_id"
    t.index ["exchange_id"], name: "fsc_ind_crypto_exchanges_on_exchange_id"
  end

  create_table "fsc_cryptos", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fsc_exchanges", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.decimal "maker_fee", precision: 8, scale: 6, null: false
    t.decimal "taker_fee", precision: 8, scale: 6, null: false
    t.decimal "fiat_withdrawal_fee", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "open_orders_limit_per_trade_pair"
  end

  create_table "fsc_orders", force: :cascade do |t|
    t.string "status", null: false
    t.string "buy_or_sell", null: false
    t.decimal "price", precision: 15, scale: 10
    t.decimal "quantity", precision: 15, scale: 10
    t.bigint "trade_pair_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reference"
    t.decimal "quantity_received", precision: 15, scale: 10
    t.bigint "order_id"
    t.decimal "percentage_from_market_price", precision: 8, scale: 6
    t.index ["order_id"], name: "fsc_ind_orders_on_order_id"
    t.index ["trade_pair_id"], name: "fsc_ind_orders_on_trade_pair_id"
  end

  create_table "fsc_payment_summaries", force: :cascade do |t|
    t.integer "total_tax_withheld"
    t.integer "year_ending"
    t.integer "total_allowances"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "year_ending"], name: "fsc_ind_payment_summaries_on_client_id_and_year_ending", unique: true
  end

  create_table "fsc_projects", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "title", null: false
    t.string "url"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "end_date"
    t.boolean "private", default: true
    t.string "role"
  end

  create_table "fsc_projects_tools", id: false, force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "tool_id"
    t.index ["project_id"], name: "fsc_ind_projects_tools_on_project_id"
    t.index ["tool_id"], name: "fsc_ind_projects_tools_on_tool_id"
  end

  create_table "fsc_properties", force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fsc_scheduled_tranxaction_templates", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.bigint "creditor_id"
    t.date "date", null: false
    t.integer "days_for_recurrence"
    t.string "description", null: false
    t.boolean "enabled"
    t.boolean "tax"
    t.bigint "tax_category_id"
    t.string "tranxactable_type", null: false
    t.bigint "tranxactable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "date_offset", default: 0
    t.index ["creditor_id"], name: "fsc_ind_scheduled_tranxaction_templates_on_creditor_id"
    t.index ["tax_category_id"], name: "fsc_ind_scheduled_tranxaction_templates_on_tax_category_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "fsc_ind_tranxaction_schedules_on_tranxactable"
  end

  create_table "fsc_tax_categories", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fsc_tenancy_agreements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.date "starting_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.decimal "bond", precision: 18, scale: 8, default: "0.0"
    t.boolean "active", default: true
    t.boolean "tax", default: true
    t.index ["property_id"], name: "index_fsc_tenancy_agreements_on_property_id"
    t.index ["user_id"], name: "index_fsc_tenancy_agreements_on_user_id"
  end

  create_table "fsc_tools", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "visible"
    t.index ["name"], name: "fsc_ind_tools_on_name", unique: true
  end

  create_table "fsc_trade_pairs", force: :cascade do |t|
    t.string "symbol", null: false
    t.decimal "maker_fee", precision: 8, scale: 6
    t.decimal "taker_fee", precision: 8, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "minimum_total", precision: 15, scale: 10
    t.decimal "amount_step", precision: 15, scale: 10
    t.boolean "enabled"
    t.integer "price_precision"
    t.integer "open_orders_limit"
    t.integer "accumulate_time_limit_in_seconds"
    t.bigint "credential_id"
    t.integer "mode", default: 0
    t.decimal "minimum_hodl_quantity", precision: 15, scale: 10
    t.decimal "maximum_hodl_quantity", precision: 15, scale: 10
    t.decimal "percentage_from_market_price_buy_minimum", precision: 8, scale: 6
    t.decimal "percentage_from_market_price_buy_maximum", precision: 8, scale: 6
    t.decimal "limit_price", precision: 15, scale: 10
    t.decimal "accumulate_amount", precision: 15, scale: 10
    t.integer "market_type", default: 0, null: false
    t.integer "side_effect_type", default: 0, null: false
    t.index ["credential_id"], name: "fsc_ind_trade_pairs_on_credential_id"
  end

  create_table "fsc_tranxactions", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tax"
    t.integer "tax_category_id"
    t.bigint "creditor_id"
    t.string "tranxactable_type"
    t.bigint "tranxactable_id"
    t.index ["creditor_id"], name: "fsc_ind_tranxactions_on_creditor_id"
    t.index ["tax_category_id"], name: "index_fsc_tranxactions_on_tax_category_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "fsc_ind_tranxactions_on_tranxactable_type_and_tranxactable_id"
  end

  create_table "fsc_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin", default: false
    t.string "medicare_number"
    t.string "medicare_expiry"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.index ["email"], name: "fsc_ind_users_on_email", unique: true
    t.index ["reset_password_token"], name: "fsc_ind_users_on_reset_password_token", unique: true
    t.index ["username"], name: "fsc_ind_users_on_username", unique: true
  end

  add_foreign_key "fsc_achievements", "fsc_projects", column: "project_id", name: "fsc_achievements_project_id_fk"
  add_foreign_key "fsc_credentials", "fsc_exchanges", column: "exchange_id", name: "fsc_credentials_exchange_id_fk"
  add_foreign_key "fsc_orders", "fsc_orders", column: "order_id", name: "fsc_orders_order_id_fk"
  add_foreign_key "fsc_orders", "fsc_trade_pairs", column: "trade_pair_id", name: "fsc_orders_trade_pair_id_fk"
  add_foreign_key "fsc_payment_summaries", "fsc_clients", column: "client_id", name: "fsc_payment_summaries_client_id_fk"
  add_foreign_key "fsc_projects_tools", "fsc_projects", column: "project_id", name: "fsc_projects_tools_project_id_fk"
  add_foreign_key "fsc_projects_tools", "fsc_tools", column: "tool_id", name: "fsc_projects_tools_tool_id_fk"
  add_foreign_key "fsc_scheduled_tranxaction_templates", "fsc_creditors", column: "creditor_id", name: "fsc_scheduled_tranxaction_templates_creditor_id_fk"
  add_foreign_key "fsc_scheduled_tranxaction_templates", "fsc_tax_categories", column: "tax_category_id", name: "fsc_scheduled_tranxaction_templates_tax_category_id_fk"
  add_foreign_key "fsc_tenancy_agreements", "fsc_properties", column: "property_id", name: "fsc_tenancy_agreements_property_id_fk"
  add_foreign_key "fsc_tenancy_agreements", "fsc_users", column: "user_id", name: "fsc_tenancy_agreements_user_id_fk"
  add_foreign_key "fsc_trade_pairs", "fsc_credentials", column: "credential_id", name: "fsc_trade_pairs_credential_id_fk"
  add_foreign_key "fsc_tranxactions", "fsc_creditors", column: "creditor_id", name: "fsc_tranxactions_creditor_id_fk"
  add_foreign_key "fsc_tranxactions", "fsc_tax_categories", column: "tax_category_id", name: "fsc_tranxactions_tax_category_id_fk"
end
