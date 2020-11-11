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

ActiveRecord::Schema.define(version: 2020_11_11_023230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_achievements_on_project_id"
  end

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

  create_table "attachments", force: :cascade do |t|
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cloudinary_public_id"
    t.integer "file_type", default: 1
  end

  create_table "blog_posts", force: :cascade do |t|
    t.text "description"
    t.string "title", null: false
    t.datetime "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "private", default: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creditors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_creditors_on_name", unique: true
  end

  create_table "crypto_exchanges", force: :cascade do |t|
    t.bigint "crypto_id"
    t.bigint "exchange_id"
    t.decimal "withdrawal_fee", precision: 8, scale: 6
    t.decimal "maker_fee", precision: 8, scale: 6
    t.decimal "taker_fee", precision: 8, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crypto_id"], name: "index_crypto_exchanges_on_crypto_id"
    t.index ["exchange_id"], name: "index_crypto_exchanges_on_exchange_id"
  end

  create_table "cryptos", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.decimal "maker_fee", precision: 8, scale: 6, null: false
    t.decimal "taker_fee", precision: 8, scale: 6, null: false
    t.decimal "fiat_withdrawal_fee", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
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
    t.index ["order_id"], name: "index_orders_on_order_id"
    t.index ["trade_pair_id"], name: "index_orders_on_trade_pair_id"
  end

  create_table "payment_summaries", force: :cascade do |t|
    t.integer "total_tax_withheld"
    t.integer "year_ending"
    t.integer "total_allowances"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "year_ending"], name: "index_payment_summaries_on_client_id_and_year_ending", unique: true
  end

  create_table "projects", force: :cascade do |t|
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

  create_table "projects_tools", id: false, force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "tool_id"
    t.index ["project_id"], name: "index_projects_tools_on_project_id"
    t.index ["tool_id"], name: "index_projects_tools_on_tool_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_tranxaction_templates", force: :cascade do |t|
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
    t.index ["creditor_id"], name: "index_scheduled_tranxaction_templates_on_creditor_id"
    t.index ["tax_category_id"], name: "index_scheduled_tranxaction_templates_on_tax_category_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "index_tranxaction_schedules_on_tranxactable"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "level"
    t.integer "lines"
    t.index ["project_id"], name: "index_scores_on_project_id"
  end

  create_table "tax_categories", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tenancy_agreements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.date "starting_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.decimal "bond", precision: 18, scale: 8, default: "0.0"
    t.boolean "active", default: true
    t.boolean "tax", default: true
  end

  create_table "tools", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "visible"
    t.index ["name"], name: "index_tools_on_name", unique: true
  end

  create_table "trade_pairs", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "url"
    t.bigint "exchange_id"
    t.decimal "maker_fee", precision: 8, scale: 6
    t.decimal "taker_fee", precision: 8, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "minimum_total", precision: 15, scale: 10
    t.decimal "amount_step", precision: 15, scale: 10
    t.boolean "active_for_accumulation"
    t.integer "price_precision"
    t.integer "open_orders_limit"
    t.integer "accumulate_time_limit_in_seconds"
    t.index ["exchange_id"], name: "index_trade_pairs_on_exchange_id"
  end

  create_table "tranxactions", force: :cascade do |t|
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
    t.index ["creditor_id"], name: "index_tranxactions_on_creditor_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "index_tranxactions_on_tranxactable_type_and_tranxactable_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "achievements", "projects", name: "achievements_project_id_fk"
  add_foreign_key "orders", "orders"
  add_foreign_key "orders", "trade_pairs", name: "orders_trade_pair_id_fk"
  add_foreign_key "payment_summaries", "clients", name: "payment_summaries_client_id_fk"
  add_foreign_key "projects_tools", "projects", name: "projects_tools_project_id_fk"
  add_foreign_key "projects_tools", "tools", name: "projects_tools_tool_id_fk"
  add_foreign_key "scheduled_tranxaction_templates", "creditors", name: "scheduled_tranxaction_templates_creditor_id_fk"
  add_foreign_key "scheduled_tranxaction_templates", "tax_categories", name: "scheduled_tranxaction_templates_tax_category_id_fk"
  add_foreign_key "scores", "projects", name: "scores_project_id_fk"
  add_foreign_key "tenancy_agreements", "properties", name: "tenancy_agreements_property_id_fk"
  add_foreign_key "tenancy_agreements", "users", name: "tenancy_agreements_user_id_fk"
  add_foreign_key "trade_pairs", "exchanges", name: "trade_pairs_exchange_id_fk"
  add_foreign_key "tranxactions", "creditors", name: "tranxactions_creditor_id_fk"
  add_foreign_key "tranxactions", "tax_categories", name: "tranxactions_tax_category_id_fk"
end
