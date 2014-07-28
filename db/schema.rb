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

ActiveRecord::Schema.define(version: 20140728185030) do

  create_table "deets", force: true do |t|
    t.string   "about_me"
    t.string   "lifestyle"
    t.string   "profession"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "img"
  end

  create_table "first_date_prefs", force: true do |t|
    t.integer  "user_id"
    t.integer  "first_date_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "first_dates", force: true do |t|
    t.string   "types"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lifestyle_prefs", force: true do |t|
    t.integer  "user_id"
    t.integer  "lifestyle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lifestyles", force: true do |t|
    t.string   "types"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
    t.integer  "user_id"
  end

  create_table "preferences", force: true do |t|
    t.integer  "user_id"
    t.string   "gender_pref"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "img"
    t.integer  "age"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flag"
    t.string   "password_digest"
  end

end
