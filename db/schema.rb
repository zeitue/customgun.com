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

ActiveRecord::Schema.define(version: 20160521165207) do

  create_table "images", force: :cascade do |t|
    t.string   "file_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
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
    t.string   "schematic"
    t.float    "weight"
    t.float    "height"
    t.float    "width"
    t.float    "length"
    t.string   "tags"
    t.string   "categories"
    t.boolean  "exclusive"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
