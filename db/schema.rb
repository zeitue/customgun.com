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

ActiveRecord::Schema.define(version: 20160531003852) do

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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "store"
    t.string   "caliber"
    t.string   "material"
    t.string   "barrel_length"
    t.string   "type_field"
    t.string   "style_field"
    t.string   "url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zip_code"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
