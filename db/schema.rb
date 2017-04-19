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

ActiveRecord::Schema.define(version: 20170418091736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_events", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_suppliers", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_suppliers", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.string   "review"
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "attendee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.boolean  "accepted"
    t.integer  "rating"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "location"
    t.integer  "capacity"
    t.string   "description"
    t.string   "image_url"
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "expertise"
    t.integer  "cost_per_person"
    t.string   "description"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "gender"
    t.string   "image_url"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
