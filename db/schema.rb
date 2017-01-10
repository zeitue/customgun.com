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

ActiveRecord::Schema.define(version: 20170110014432) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "fax"
    t.string   "company"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boxes", force: :cascade do |t|
    t.string   "provider"
    t.float    "length"
    t.float    "height"
    t.float    "width"
    t.float    "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "shipment_id"
  end

  add_index "items", ["order_id"], name: "index_items_on_order_id"
  add_index "items", ["product_id"], name: "index_items_on_product_id"
  add_index "items", ["shipment_id"], name: "index_items_on_shipment_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.float    "subtotal"
    t.float    "total"
    t.float    "tax"
    t.integer  "address_id"
    t.float    "shipping"
    t.text     "comment",    default: ""
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "part_number"
    t.float    "price"
    t.integer  "quantity"
    t.text     "description"
    t.float    "weight"
    t.float    "height"
    t.float    "width"
    t.float    "length"
    t.string   "tags"
    t.boolean  "exclusive"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "store"
    t.string   "caliber"
    t.string   "material"
    t.string   "barrel_length"
    t.string   "type_field"
    t.string   "style_field"
    t.string   "url"
    t.boolean  "active",                   default: true
    t.string   "shipped_by"
    t.boolean  "sale",                     default: false
    t.float    "sale_price"
    t.float    "field_of_view_low_power"
    t.float    "field_of_view_high_power"
    t.string   "diopter_adjustment"
    t.float    "eye_relief"
    t.float    "exit_pupil_low_power"
    t.float    "exit_pupil_high_power"
    t.string   "elevation_travel"
    t.string   "windage_travel"
    t.float    "moa_per_click_upper"
    t.float    "moa_per_click_lower"
    t.boolean  "parallax_compensation",    default: false
    t.string   "total_travel"
    t.float    "tube_diameter"
    t.string   "position_of_reticle"
    t.string   "available_reticles"
    t.datetime "sale_end"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "tracking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "shipped_by"
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id"

  create_table "shippers", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "company_name",   default: ""
    t.integer  "scheme",         default: 0
    t.float    "price",          default: 0.0
    t.float    "handling_fee",   default: 0.0
    t.float    "up_charge_rate", default: 0.0
    t.integer  "address_id"
    t.boolean  "usps",           default: false
    t.boolean  "fedex",          default: false
    t.boolean  "ups",            default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "shippers", ["address_id"], name: "index_shippers_on_address_id"

  create_table "shipping_methods", force: :cascade do |t|
    t.integer  "order_id"
    t.float    "price"
    t.string   "service_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "shipping_methods", ["order_id"], name: "index_shipping_methods_on_order_id"

  create_table "units", force: :cascade do |t|
    t.integer  "shipment_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "units", ["product_id"], name: "index_units_on_product_id"
  add_index "units", ["shipment_id"], name: "index_units_on_shipment_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.boolean  "guest"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
