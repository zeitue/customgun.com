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

ActiveRecord::Schema.define(version: 20180116212743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.text "address_line1"
    t.text "address_line2"
    t.text "country"
    t.text "state"
    t.text "city"
    t.text "zip"
    t.text "phone"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "prefix"
    t.text "first_name"
    t.text "middle_name"
    t.text "last_name"
    t.text "suffix"
    t.text "fax"
    t.text "company"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "provider"
    t.text "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boxes", id: :serial, force: :cascade do |t|
    t.text "provider"
    t.float "length"
    t.float "height"
    t.float "width"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipment_id"
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["shipment_id"], name: "index_items_on_shipment_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "subtotal"
    t.float "total"
    t.float "tax"
    t.integer "address_id"
    t.float "shipping"
    t.text "comment"
    t.datetime "ordered_on"
    t.integer "phase", default: 0
    t.boolean "voided", default: false, null: false
    t.integer "items_count", default: 0, null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.text "title"
    t.text "manufacturer"
    t.text "model"
    t.text "part_number"
    t.float "price"
    t.integer "quantity"
    t.text "description"
    t.float "weight"
    t.float "height"
    t.float "width"
    t.float "length"
    t.text "tags"
    t.boolean "exclusive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "store"
    t.text "caliber"
    t.text "material"
    t.text "barrel_length"
    t.text "type_field"
    t.text "style_field"
    t.text "url"
    t.boolean "active", default: true
    t.text "shipped_by"
    t.boolean "sale", default: false
    t.float "sale_price"
    t.float "field_of_view_low_power"
    t.float "field_of_view_high_power"
    t.text "diopter_adjustment"
    t.float "eye_relief"
    t.float "exit_pupil_low_power"
    t.float "exit_pupil_high_power"
    t.text "elevation_travel"
    t.text "windage_travel"
    t.float "moa_per_click_upper"
    t.float "moa_per_click_lower"
    t.boolean "parallax_compensation", default: false
    t.text "total_travel"
    t.float "tube_diameter"
    t.text "position_of_reticle"
    t.text "available_reticles"
    t.datetime "sale_end"
    t.integer "shipper_id"
    t.boolean "has_box", default: false
    t.float "shipping_height", default: 0.0
    t.float "shipping_width", default: 0.0
    t.float "shipping_length", default: 0.0
    t.float "shipping_weight", default: 0.0
    t.boolean "compressible", default: false, null: false
    t.index ["shipper_id"], name: "index_products_on_shipper_id"
  end

  create_table "shipments", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.text "tracking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "shipped_by"
    t.index ["order_id"], name: "index_shipments_on_order_id"
  end

  create_table "shippers", id: :serial, force: :cascade do |t|
    t.text "name", default: ""
    t.text "company_name", default: ""
    t.integer "scheme", default: 0
    t.float "price", default: 0.0
    t.float "handling_fee", default: 0.0
    t.float "up_charge_rate", default: 0.0
    t.integer "address_id"
    t.boolean "usps", default: false
    t.boolean "fedex", default: false
    t.boolean "ups", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_shippers_on_address_id"
  end

  create_table "shipping_methods", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.float "price"
    t.text "service_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shipping_methods_on_order_id"
  end

  create_table "tiles", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "text", default: "", null: false
    t.string "url", default: "", null: false
    t.string "group", default: "", null: false
    t.string "image", default: "", null: false
    t.boolean "show", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "major"
    t.integer "minor"
  end

  create_table "units", id: :serial, force: :cascade do |t|
    t.integer "shipment_id"
    t.integer "product_id"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_units_on_product_id"
    t.index ["shipment_id"], name: "index_units_on_shipment_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.text "email"
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text "current_sign_in_ip"
    t.text "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.boolean "guest"
    t.text "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text "unconfirmed_email"
    t.text "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
