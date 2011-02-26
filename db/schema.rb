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

ActiveRecord::Schema.define(:version => 20110226081214) do

  create_table "problem_attempts", :force => true do |t|
    t.string   "status"
    t.string   "file_hash"
    t.integer  "problem_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.string   "filetype"
  end

  create_table "problems", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "example"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "email_address"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",        :default => false
  end

end
