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

ActiveRecord::Schema.define(:version => 20120209181033) do

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contemporary_issues_content_fragments", :id => false, :force => true do |t|
    t.integer "contemporary_issue_id"
    t.integer "content_fragment_id"
  end

  create_table "content_fragments", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "published"
    t.datetime "published_at"
    t.text     "teaser"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "weight"
    t.string   "name"
  end

  add_index "content_fragments", ["url"], :name => "index_content_fragments_on_url", :unique => true
  add_index "content_fragments", ["user_id"], :name => "index_content_fragments_on_user_id"

  create_table "content_fragments_person_types", :id => false, :force => true do |t|
    t.integer "content_fragment_id"
    t.integer "person_type_id"
  end

  create_table "menu_items", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.integer  "person_type_id"
    t.boolean  "speaker"
    t.string   "role_list"
    t.integer  "chapter_id"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
