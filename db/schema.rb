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

ActiveRecord::Schema.define(:version => 20110905031244) do

  create_table "items", :force => true do |t|
    t.integer "owner_id",   :null => false
    t.string  "owner_type", :null => false
    t.string  "instance"
  end

  create_table "players", :force => true do |t|
    t.string  "name",           :null => false
    t.string  "password_hash"
    t.string  "password_salt"
    t.string  "pending_output"
    t.boolean "logging_out"
    t.integer "room_id"
  end

  add_index "players", ["name"], :name => "index_players_on_name"

  create_table "rooms", :force => true do |t|
    t.string "name", :null => false
    t.string "desc"
  end

  add_index "rooms", ["name"], :name => "index_rooms_on_name"

end
