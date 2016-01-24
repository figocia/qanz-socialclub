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

ActiveRecord::Schema.define(version: 20160124154619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.boolean  "is_finished", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_participants", force: true do |t|
    t.integer  "participant_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "member_only",                            default: false
    t.decimal  "non_member_fee", precision: 5, scale: 2
    t.string   "image"
  end

  create_table "games", force: true do |t|
    t.boolean  "is_finished"
    t.integer  "team_one_score", default: 0
    t.integer  "team_two_score", default: 0
    t.integer  "team_one_id"
    t.integer  "team_two_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  create_table "rounds", force: true do |t|
    t.string   "name"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: true do |t|
    t.integer  "member_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_member",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",             default: false
    t.string   "password_digest"
    t.string   "membership_token"
    t.string   "reset_password_token"
  end

end
