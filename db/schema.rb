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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130618214443) do

  create_table "flags", :force => true do |t|
    t.string "key"
    t.string "desc"
    t.string "style"
  end

  create_table "tune_user_flags", :force => true do |t|
  end

  create_table "tunes", :force => true do |t|
    t.integer "track_id"
    t.string  "track_title"
    t.integer "artist_id"
    t.string  "artist_name"
    t.string  "image_url"
    t.string  "buy_url"
  end

  create_table "user_tune_flags", :force => true do |t|
    t.integer "user_id"
    t.integer "tune_id"
    t.integer "flag_id"
  end

end
