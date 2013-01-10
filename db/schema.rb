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

ActiveRecord::Schema.define(:version => 20130110050659) do

  create_table "affiliations", :force => true do |t|
    t.integer   "dude_id"
    t.integer   "project_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "dudes", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.text      "bio"
    t.string    "website"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "ruby_gems_id"
    t.boolean   "featured",     :default => false
    t.string    "twitter"
    t.string    "github"
    t.string    "image_url"
  end

  create_table "projects", :force => true do |t|
    t.string    "name"
    t.string    "url"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text      "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "talks", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.string  "presenter"
    t.string  "kind"
    t.string  "email",          :default => "",    :null => false
    t.boolean "completed",      :default => false
    t.date    "scheduled_date"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "confirmation_token"
    t.timestamp "confirmed_at"
    t.timestamp "confirmation_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
