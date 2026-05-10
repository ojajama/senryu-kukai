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

ActiveRecord::Schema[8.1].define(version: 2026_05_10_124500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.bigint "post_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.integer "len"
    t.string "pos"
    t.string "reading"
    t.datetime "updated_at", null: false
    t.string "word", null: false
    t.index ["category"], name: "index_keywords_on_category"
    t.index ["len"], name: "index_keywords_on_len"
    t.index ["pos"], name: "index_keywords_on_pos"
    t.index ["reading"], name: "index_keywords_on_reading"
    t.index ["word"], name: "index_keywords_on_word", unique: true
  end

  create_table "kukai_keywords", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "keyword_id", null: false
    t.bigint "kukai_id", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_kukai_keywords_on_keyword_id"
    t.index ["kukai_id"], name: "index_kukai_keywords_on_kukai_id"
  end

  create_table "kukais", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "month"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "post_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "post_revisions", force: :cascade do |t|
    t.text "after_verse"
    t.text "ai_comment"
    t.text "before_verse"
    t.datetime "created_at", null: false
    t.bigint "post_id", null: false
    t.datetime "updated_at", null: false
    t.text "verse"
    t.index ["post_id"], name: "index_post_revisions_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "keyword_id", null: false
    t.bigint "kukai_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "verse"
    t.index ["keyword_id"], name: "index_posts_on_keyword_id"
    t.index ["kukai_id"], name: "index_posts_on_kukai_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index "lower((nickname)::text)", name: "index_users_on_lower_nickname", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "kukai_keywords", "keywords"
  add_foreign_key "kukai_keywords", "kukais"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "post_revisions", "posts"
  add_foreign_key "posts", "keywords"
  add_foreign_key "posts", "kukais"
  add_foreign_key "posts", "users"
end
