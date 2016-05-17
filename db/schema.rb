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

ActiveRecord::Schema.define(version: 20160517030629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "date_reserveds", force: :cascade do |t|
    t.date     "date_reserved"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "homes", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price_per_night"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          default: 0
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "order_tools", force: :cascade do |t|
    t.integer  "tool_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_tools", ["order_id"], name: "index_order_tools_on_order_id", using: :btree
  add_index "order_tools", ["tool_id"], name: "index_order_tools_on_tool_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "closed_at"
    t.decimal  "total"
    t.integer  "quantity"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "home_id"
  end

  add_index "photos", ["home_id"], name: "index_photos_on_home_id", using: :btree

  create_table "reservation_nights", force: :cascade do |t|
    t.integer "reservation_id"
    t.date    "night"
  end

  add_index "reservation_nights", ["reservation_id"], name: "index_reservation_nights_on_reservation_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "checkin"
    t.date     "checkout"
    t.integer  "order_id"
    t.integer  "home_id"
  end

  add_index "reservations", ["home_id"], name: "index_reservations_on_home_id", using: :btree
  add_index "reservations", ["order_id"], name: "index_reservations_on_order_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price"
    t.string   "image_path"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "inventory"
  end

  add_index "tools", ["category_id"], name: "index_tools_on_category_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "role",                default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "description"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "slug"
    t.integer  "status",              default: 0
  end

  add_foreign_key "order_tools", "orders"
  add_foreign_key "order_tools", "tools"
  add_foreign_key "orders", "users"
  add_foreign_key "photos", "homes"
  add_foreign_key "reservation_nights", "reservations"
  add_foreign_key "reservations", "homes"
  add_foreign_key "reservations", "orders"
  add_foreign_key "tools", "categories"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
