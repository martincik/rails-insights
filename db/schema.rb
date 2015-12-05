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

ActiveRecord::Schema.define(version: 20151205123751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "homepage_url"
    t.string   "homepage_domain"
    t.string   "logo_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "portals", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "domain"
    t.string   "scraper_class"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "feed_url"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "company_id"
    t.integer  "portal_id"
    t.string   "title"
    t.text     "description_html"
    t.text     "description_text"
    t.text     "how_to_apply"
    t.string   "url"
    t.string   "location"
    t.string   "salary"
    t.string   "visibility"
    t.string   "state",            default: "pending"
    t.string   "kind"
    t.string   "type"
    t.datetime "posted_at"
    t.datetime "synchronized_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "archived_at"
  end

  add_index "positions", ["company_id"], name: "index_positions_on_company_id", using: :btree
  add_index "positions", ["portal_id"], name: "index_positions_on_portal_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "positions", "companies"
  add_foreign_key "positions", "portals"
end
