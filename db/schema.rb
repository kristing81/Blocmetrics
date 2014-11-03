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

ActiveRecord::Schema.define(version: 20141103123915) do

  create_table "events", force: true do |t|
    t.integer  "tracked_domain_id"
    t.string   "event_type"
    t.string   "url"
    t.string   "ip_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "events", ["tracked_domain_id"], name: "index_events_on_tracked_domain_id"

  create_table "tracked_domains", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "verification_code"
    t.boolean  "verified",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "tracked_domains", ["user_id"], name: "index_tracked_domains_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
