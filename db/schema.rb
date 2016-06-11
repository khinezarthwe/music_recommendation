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

ActiveRecord::Schema.define(version: 20160610113453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allsongs", force: :cascade do |t|
    t.string   "lastfm_userid"
    t.datetime "timestamp"
    t.string   "artist_id"
    t.string   "artist_name"
    t.string   "traid"
    t.string   "trackname"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "songs", force: :cascade do |t|
    t.integer  "topic_num"
    t.text     "artist_name"
    t.text     "song_name"
    t.text     "lyric"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "traid"
  end

  add_index "songs", ["user_id", "created_at"], name: "index_songs_on_user_id_and_created_at", using: :btree
  add_index "songs", ["user_id"], name: "index_songs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "age"
    t.string   "gender"
    t.string   "occupation"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "songs", "users"
end
