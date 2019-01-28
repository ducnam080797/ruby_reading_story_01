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

ActiveRecord::Schema.define(version: 2019_01_25_094122) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_stories", id: false, force: :cascade do |t|
    t.integer "story_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_categories_stories_on_category_id"
    t.index ["story_id"], name: "index_categories_stories_on_story_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.string "image"
    t.integer "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_chapters_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "author_name"
    t.string "cover_image"
    t.integer "progress"
    t.string "description"
    t.integer "liked"
    t.integer "user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
