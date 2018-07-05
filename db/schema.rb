# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180705072624) do

  create_table "bets", force: :cascade do |t|
    t.decimal "odds", precision: 18, scale: 8, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.text "description"
    t.string "image_url"
    t.string "title", null: false
    t.string "youtube_url"
    t.datetime "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts_tags", id: false, force: :cascade do |t|
    t.integer "blog_post_id"
    t.integer "tag_id"
    t.index ["blog_post_id"], name: "index_blog_posts_tags_on_blog_post_id"
    t.index ["tag_id"], name: "index_blog_posts_tags_on_tag_id"
  end

  create_table "cleaning_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cleaning_task_id"
    t.date "date"
  end

  create_table "cleaning_tasks", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_payments", force: :cascade do |t|
    t.integer "client_id", null: false
    t.decimal "amount", precision: 18, scale: 8, default: "0.0"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creditors", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "balance", precision: 18, scale: 8, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "farming_transactions", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "amount", precision: 18, scale: 8, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.date "date"
    t.decimal "odds", precision: 18, scale: 8
    t.boolean "farming"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "cost", precision: 18, scale: 8, default: "0.0"
    t.boolean "taxable", default: true
  end

  create_table "levels", force: :cascade do |t|
    t.integer "score_id", null: false
    t.integer "level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["score_id"], name: "index_levels_on_score_id"
  end

  create_table "lines", force: :cascade do |t|
    t.integer "score_id", null: false
    t.integer "lines", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["score_id"], name: "index_lines_on_score_id"
  end

  create_table "market_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.integer "market_type_id", null: false
    t.integer "match_id", null: false
    t.float "odds", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "match_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "league"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_id", null: false
    t.integer "away_id", null: false
    t.integer "match_type_id", null: false
    t.datetime "date", null: false
    t.integer "home_score"
    t.integer "away_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bookie_match_id"
    t.string "website"
  end

  create_table "projects", force: :cascade do |t|
    t.text "description"
    t.string "image_url"
    t.string "title", null: false
    t.string "url"
    t.datetime "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_transactions", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["project_id"], name: "index_scores_on_project_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tenancy_agreements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "address", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.date "starting_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.string "resource_class"
    t.string "resource_id"
    t.integer "transaction_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean "tenant", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
