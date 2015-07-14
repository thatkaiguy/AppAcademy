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

ActiveRecord::Schema.define(version: 20150713234133) do

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title",            null: false
    t.text     "body"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "contact_shares", force: :cascade do |t|
    t.integer  "contact_id",                  null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_favorite", default: false
  end

  add_index "contact_shares", ["contact_id"], name: "index_contact_shares_on_contact_id"
  add_index "contact_shares", ["user_id", "contact_id"], name: "index_contact_shares_on_user_id_and_contact_id", unique: true
  add_index "contact_shares", ["user_id"], name: "index_contact_shares_on_user_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_favorite", default: false
  end

  add_index "contacts", ["user_id", "email"], name: "index_contacts_on_user_id_and_email", unique: true
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "groupings", force: :cascade do |t|
    t.integer  "group_id",   null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groupings", ["contact_id"], name: "index_groupings_on_contact_id"
  add_index "groupings", ["group_id", "contact_id"], name: "index_groupings_on_group_id_and_contact_id", unique: true
  add_index "groupings", ["group_id"], name: "index_groupings_on_group_id"

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "group_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",   default: "Need username", null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
