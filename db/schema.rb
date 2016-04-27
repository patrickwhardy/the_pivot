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

ActiveRecord::Schema.define(version: 20160427171728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_tools", force: :cascade do |t|
    t.integer  "tool_id"
    t.decimal  "unit_price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cart_tools", ["tool_id"], name: "index_cart_tools_on_tool_id", using: :btree

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "closed_at"
    t.decimal  "total"
    t.integer  "quantity"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "tool_id"
    t.integer  "date_reserved_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reservations", ["date_reserved_id"], name: "index_reservations_on_date_reserved_id", using: :btree
  add_index "reservations", ["tool_id"], name: "index_reservations_on_tool_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price"
    t.string   "image_path"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "category_id"
    t.integer  "inventory",   default: 0
  end

  add_index "tools", ["category_id"], name: "index_tools_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  add_foreign_key "cart_tools", "tools"
  add_foreign_key "order_tools", "orders"
  add_foreign_key "order_tools", "tools"
  add_foreign_key "orders", "users"
  add_foreign_key "reservations", "date_reserveds"
  add_foreign_key "reservations", "tools"
  add_foreign_key "reservations", "users"
  add_foreign_key "tools", "categories"
end
