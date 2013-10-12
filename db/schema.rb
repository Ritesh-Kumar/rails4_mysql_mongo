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

ActiveRecord::Schema.define(version: 20131012140832) do

  create_table "movies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "company"
    t.text     "address"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "status"
    t.float    "amount"
    t.float    "interest_rate"
    t.string   "time_period"
    t.string   "description_typetext"
    t.text     "description_fulltext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
