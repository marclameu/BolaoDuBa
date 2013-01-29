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

ActiveRecord::Schema.define(:version => 20130127210100) do

  create_table "championships", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "gambles", :force => true do |t|
    t.integer  "active"
    t.integer  "user_id"
    t.integer  "goals_team_1"
    t.integer  "goals_team_2"
    t.integer  "match_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_points"
  end

  add_index "gambles", ["match_id"], :name => "index_gambles_on_match_id"
  add_index "gambles", ["user_id"], :name => "index_gambles_on_user_id"

  create_table "matches", :force => true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "goals_team1"
    t.integer  "goals_team2"
    t.datetime "date_match"
    t.integer  "round_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "matches", ["round_id"], :name => "index_matches_on_round_id"

  create_table "participations", :force => true do |t|
    t.integer  "championship_id"
    t.integer  "user_id"
    t.integer  "user_points"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "rounds", :force => true do |t|
    t.integer  "num_round"
    t.string   "desc"
    t.integer  "championship_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id", "user_id"], :name => "index_teams_users_on_team_id_and_user_id"
  add_index "teams_users", ["user_id", "team_id"], :name => "index_teams_users_on_user_id_and_team_id"

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.string   "email"
    t.datetime "born_date"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "Cpf"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
