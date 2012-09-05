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

ActiveRecord::Schema.define(:version => 20120905171817) do

  create_table "attendees_events", :id => false, :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendees_events", ["attendee_id"], :name => "index_attendees_events_on_attendee_id"
  add_index "attendees_events", ["event_id"], :name => "index_attendees_events_on_event_id"

  create_table "celebrants_events", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "celebrants_events", ["event_id"], :name => "index_celebrant_events_on_event_id"
  add_index "celebrants_events", ["user_id"], :name => "index_celebrant_events_on_user_id"

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  create_table "contemporary_issues_content_fragments", :id => false, :force => true do |t|
    t.integer "contemporary_issue_id"
    t.integer "content_fragment_id"
  end

  create_table "contemporary_issues_events", :id => false, :force => true do |t|
    t.integer "contemporary_issue_id"
    t.integer "event_id"
  end

  create_table "contemporary_issues_users", :id => false, :force => true do |t|
    t.integer "contemporary_issue_id"
    t.integer "user_id"
  end

  create_table "content_fragments", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "body",                        :limit => 16777215
    t.boolean  "published"
    t.datetime "published_at"
    t.text     "teaser"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "weight"
    t.string   "name"
    t.string   "category"
    t.string   "menu"
    t.boolean  "hide_header"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.string   "thumbnail_file_name"
    t.datetime "thumbnail_updated_at"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "image_file_name"
    t.datetime "image_updated_at"
    t.boolean  "feature_on_homepage"
    t.string   "translated_title"
    t.string   "homepage_image_content_type"
    t.integer  "homepage_image_file_size"
    t.string   "homepage_image_file_name"
    t.datetime "homepage_image_updated_at"
  end

  add_index "content_fragments", ["url"], :name => "index_content_fragments_on_url", :unique => true
  add_index "content_fragments", ["user_id"], :name => "index_content_fragments_on_user_id"

  create_table "content_fragments_person_types", :id => false, :force => true do |t|
    t.integer "content_fragment_id"
    t.integer "person_type_id"
  end

  create_table "content_fragments_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "content_fragment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_fragments_users", ["content_fragment_id"], :name => "index_content_fragments_users_on_content_fragment_id"
  add_index "content_fragments_users", ["user_id"], :name => "index_content_fragments_users_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "email_addresses", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encyclical_references", :force => true do |t|
    t.integer  "content_fragment_id"
    t.integer  "encyclical_id"
    t.integer  "start"
    t.integer  "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "encyclical_references", ["content_fragment_id"], :name => "index_encyclical_references_on_content_fragment_id"
  add_index "encyclical_references", ["encyclical_id"], :name => "index_encyclical_references_on_encyclical_id"

  create_table "events", :force => true do |t|
    t.string   "type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "speaker_id"
    t.string   "title"
    t.integer  "location_id"
    t.text     "body"
    t.integer  "director_id"
    t.integer  "spots_available"
    t.integer  "cost"
    t.integer  "chapter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "teaser"
    t.string   "event_type"
    t.string   "event_region"
  end

  add_index "events", ["chapter_id"], :name => "index_events_on_chapter_id"
  add_index "events", ["director_id"], :name => "index_events_on_director_id"
  add_index "events", ["location_id"], :name => "index_events_on_location_id"
  add_index "events", ["speaker_id"], :name => "index_events_on_speaker_id"

  create_table "events_person_types", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "person_type_id"
  end

  create_table "events_speakers", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "feed_entries", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "entry_id"
    t.text     "summary"
    t.datetime "published_at"
    t.integer  "feed_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_sources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
    t.string   "menu"
    t.string   "menu_type"
  end

  add_index "menu_items", ["menu"], :name => "index_menu_items_on_menu"
  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "content_fragment_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "answer_body"
  end

  add_index "questions", ["content_fragment_id"], :name => "index_questions_on_content_fragment_id"
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                      :default => "",    :null => false
    t.string   "encrypted_password",         :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              :default => 0
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
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.text     "about"
    t.boolean  "celebrant",                  :default => false
    t.string   "about_us_type"
    t.integer  "about_us_weight"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
