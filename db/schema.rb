# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180325120217) do

  create_table "blog_posts", force: :cascade do |t|
    t.text     "description"
    t.string   "image_url"
    t.string   "title",       null: false
    t.string   "youtube_url"
    t.datetime "date_added"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "blog_posts_tags", id: false, force: :cascade do |t|
    t.integer "blog_post_id"
    t.integer "tag_id"
  end

  add_index "blog_posts_tags", ["blog_post_id"], name: "index_blog_posts_tags_on_blog_post_id"
  add_index "blog_posts_tags", ["tag_id"], name: "index_blog_posts_tags_on_tag_id"

  create_table "cleaning_records", force: :cascade do |t|
    t.integer  "user_id",                                           null: false
    t.string   "description",                                       null: false
    t.decimal  "points",      precision: 3, scale: 2, default: 0.0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "cleaning_tasks", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "score_id",   null: false
    t.integer  "level",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "levels", ["score_id"], name: "index_levels_on_score_id"

  create_table "line_markets", force: :cascade do |t|
    t.integer  "nba_game_id", null: false
    t.float    "home_line"
    t.float    "away_line"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer  "score_id",   null: false
    t.integer  "lines",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lines", ["score_id"], name: "index_lines_on_score_id"

  create_table "nba_games", force: :cascade do |t|
    t.string   "william_hill_id", null: false
    t.datetime "start_date",      null: false
    t.integer  "home_id",         null: false
    t.integer  "away_id",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "nba_teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.text     "description"
    t.string   "image_url"
    t.string   "title",       null: false
    t.string   "url"
    t.datetime "date_added"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rent_transactions", force: :cascade do |t|
    t.date     "date",                                              null: false
    t.string   "description",                                       null: false
    t.decimal  "amount",      precision: 8, scale: 2, default: 0.0, null: false
    t.integer  "user_id",                                           null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "project_id", null: false
    t.integer  "score",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  add_index "scores", ["project_id"], name: "index_scores_on_project_id"

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.boolean  "tenant",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
