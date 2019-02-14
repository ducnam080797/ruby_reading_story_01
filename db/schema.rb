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

ActiveRecord::Schema.define(version: 2019_02_16_020403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_stories", id: false, force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_categories_stories_on_category_id"
    t.index ["story_id"], name: "index_categories_stories_on_story_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.integer "progress"
    t.string "image"
    t.string "content"
    t.bigint "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_chapters_on_story_id"
  end

  create_table "interactives", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "story_id"
    t.integer "interactive_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_interactives_on_story_id"
    t.index ["user_id"], name: "index_interactives_on_user_id"
  end

  create_table "likeds", force: :cascade do |t|
    t.bigint "stories_id"
    t.integer "likeable_id"
    t.string "likeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stories_id"], name: "index_likeds_on_stories_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "author_name"
    t.string "cover_image"
    t.integer "progress"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "account_name"
    t.string "email"
    t.string "avatar"
    t.boolean "admin"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
  end

  add_foreign_key "chapters", "stories"
  add_foreign_key "interactives", "stories"
  add_foreign_key "interactives", "users"
  add_foreign_key "likeds", "stories", column: "stories_id"
  add_foreign_key "stories", "users"
end
