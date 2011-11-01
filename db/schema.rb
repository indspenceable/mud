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

ActiveRecord::Schema.define(:version => 20111031084102) do

  create_table "balance_uses", :force => true do |t|
    t.string   "balance_type", :null => false
    t.datetime "ending_at",    :null => false
    t.integer  "player_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "balance_uses", ["player_id", "balance_type"], :name => "index_on_player_id_balance_types", :unique => true

  create_table "buffs", :force => true do |t|
    t.integer  "player_id",  :null => false
    t.string   "type",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "command_groups", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "prefix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "command_groups", ["prefix"], :name => "index_command_groups_on_prefix", :unique => true

  create_table "command_groups_players", :id => false, :force => true do |t|
    t.integer "player_id"
    t.integer "command_group_id"
  end

  create_table "command_names", :force => true do |t|
    t.integer  "command_id",       :null => false
    t.integer  "command_group_id", :null => false
    t.string   "name",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "command_names", ["command_group_id", "name"], :name => "index_on_command_groups_names", :unique => true
  add_index "command_names", ["command_id"], :name => "index_on_commands"
  add_index "command_names", ["name"], :name => "index_on_names"

  create_table "commands", :force => true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exits", :force => true do |t|
    t.string   "direction",      :null => false
    t.integer  "origin_id",      :null => false
    t.integer  "destination_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exits", ["origin_id", "direction"], :name => "index_exits_on_origin_id_and_direction", :unique => true

  create_table "items", :force => true do |t|
    t.integer "owner_id",   :null => false
    t.string  "owner_type", :null => false
    t.string  "type",       :null => false
  end

  create_table "mobiles", :force => true do |t|
    t.string   "type",       :null => false
    t.integer  "room_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mobiles", ["type"], :name => "index_mobiles_on_type"

  create_table "players", :force => true do |t|
    t.string  "name",                          :null => false
    t.string  "password_hash"
    t.string  "password_salt"
    t.string  "pending_output"
    t.boolean "logged_in"
    t.integer "room_id",                       :null => false
    t.text    "colors",                        :null => false
    t.integer "exp",            :default => 0, :null => false
    t.integer "hp"
    t.integer "mp"
    t.integer "left_hand_id"
    t.integer "right_hand_id"
  end

  add_index "players", ["name"], :name => "index_players_on_name"

  create_table "rat_details", :force => true do |t|
    t.integer  "rat_id"
    t.integer  "toughness",  :default => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rat_details", ["rat_id"], :name => "index_rat_details_on_rat_id", :unique => true

  create_table "rooms", :force => true do |t|
    t.string "name", :null => false
    t.string "desc"
  end

  add_index "rooms", ["name"], :name => "index_rooms_on_name"

end
