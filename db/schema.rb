# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_04_053940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace", null: false
    t.text "body", null: false
    t.string "resource_type", null: false
    t.bigint "resource_id", null: false
    t.string "author_type", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "file_type", default: 1
    t.string "cloudinary_public_id"
    t.index ["resource_id", "resource_type"], name: "index_attachments_on_resource_id_and_resource_type"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.text "description"
    t.string "title", null: false
    t.datetime "date_added", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "private", default: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "creditors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index "lower((name)::text)", name: "index_creditors_on_LOWER_name", unique: true
    t.index ["user_id"], name: "index_creditors_on_user_id"
  end

  create_table "payment_summaries", force: :cascade do |t|
    t.integer "total_tax_withheld"
    t.integer "year_ending"
    t.integer "total_allowances"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["client_id", "year_ending"], name: "index_payment_summaries_on_client_id_and_year_ending", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.text "description"
    t.string "title", null: false
    t.string "url"
    t.date "start_date", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "scheduled_tranxaction_templates", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.bigint "creditor_id", null: false
    t.date "date", null: false
    t.integer "days_for_recurrence", null: false
    t.string "description", null: false
    t.boolean "enabled"
    t.boolean "tax"
    t.bigint "tax_category_id"
    t.string "tranxactable_type", null: false
    t.bigint "tranxactable_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "date_offset", default: 0
    t.index ["creditor_id"], name: "index_scheduled_tranxaction_templates_on_creditor_id"
    t.index ["tax_category_id"], name: "index_scheduled_tranxaction_templates_on_tax_category_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "index_tranxaction_schedules_on_tranxactable"
  end

  create_table "tax_categories", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index "lower((description)::text)", name: "index_tax_categories_on_LOWER_description", unique: true
  end

  create_table "tenancy_agreements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.date "starting_date", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "property_id", null: false
    t.decimal "bond", precision: 18, scale: 8, default: "0.0"
    t.boolean "active", default: true
    t.boolean "tax", default: true
    t.index ["property_id"], name: "index_tenancy_agreements_on_property_id"
    t.index ["user_id"], name: "index_tenancy_agreements_on_user_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible"
    t.index "lower((name)::text)", name: "index_tools_on_LOWER_name", unique: true
  end

  create_table "tranxactions", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "tax"
    t.bigint "tax_category_id"
    t.bigint "creditor_id"
    t.string "tranxactable_type"
    t.bigint "tranxactable_id"
    t.index ["creditor_id"], name: "index_tranxactions_on_creditor_id"
    t.index ["tax_category_id"], name: "index_tranxactions_on_tax_category_id"
    t.index ["tranxactable_type", "tranxactable_id"], name: "index_tranxactions_on_tranxactable_type_and_tranxactable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
    t.boolean "admin", default: false
    t.string "medicare_number"
    t.string "medicare_expiry"
    t.string "otp_secret"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payment_summaries", "clients", name: "payment_summaries_client_id_fk"
  add_foreign_key "projects_tools", "projects", name: "projects_tools_project_id_fk"
  add_foreign_key "projects_tools", "tools", name: "projects_tools_tool_id_fk"
  add_foreign_key "scheduled_tranxaction_templates", "creditors", name: "scheduled_tranxaction_templates_creditor_id_fk"
  add_foreign_key "scheduled_tranxaction_templates", "tax_categories", name: "scheduled_tranxaction_templates_tax_category_id_fk"
  add_foreign_key "tenancy_agreements", "properties", name: "tenancy_agreements_property_id_fk"
  add_foreign_key "tenancy_agreements", "users", name: "tenancy_agreements_user_id_fk"
  add_foreign_key "tranxactions", "creditors", name: "tranxactions_creditor_id_fk"
  add_foreign_key "tranxactions", "tax_categories", name: "tranxactions_tax_category_id_fk"
end
