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

ActiveRecord::Schema.define(version: 20150320205935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text     "description"
    t.integer  "hours",       default: 1,            null: false
    t.integer  "minutes",     default: 0,            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "worked_at",   default: '2015-03-18', null: false
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id", using: :btree
  add_index "user_projects", ["user_id", "project_id"], name: "index_user_projects_on_user_id_and_project_id", unique: true, using: :btree
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name",          default: "N/A", null: false
    t.string   "last_name",           default: "N/A", null: false
    t.boolean  "admin",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
