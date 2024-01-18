# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_16_083116) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "title", null: false
    t.jsonb "synonyms", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_brands_on_title", unique: true
  end

  create_table "car_parks", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "kind", null: false
    t.string "business_id_number", null: false
    t.string "contact_phone"
    t.string "bank_name"
    t.string "bank_account_number"
    t.string "email"
    t.string "card_id_number"
    t.string "privateer_number"
    t.date "privateer_date"
    t.string "residence_address"
    t.string "bank_code"
    t.string "benificiary_code"
    t.string "legal_address"
    t.string "service_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "business_id_number"], name: "index_car_parks_on_city_id_and_business_id_number", unique: true
    t.index ["city_id"], name: "index_car_parks_on_city_id"
    t.index ["user_id"], name: "index_car_parks_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "mark_id", null: false
    t.string "ownerable_type", null: false
    t.bigint "ownerable_id", null: false
    t.integer "year", limit: 2, null: false
    t.string "vin_code", null: false
    t.string "plate_number", null: false
    t.string "klass", null: false
    t.string "technical_certificate_number", null: false
    t.integer "mileage"
    t.string "fuel"
    t.string "color"
    t.string "transmission", null: false
    t.string "status", default: "vacant", null: false
    t.integer "number_of_seats", limit: 2
    t.integer "tank_volume", limit: 2
    t.integer "engine_capacity", limit: 2
    t.string "engine_capacity_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mark_id"], name: "index_cars_on_mark_id"
    t.index ["ownerable_id", "ownerable_type", "plate_number"], name: "index_cars_on_ownerable_id_and_ownerable_type_and_plate_number", unique: true
    t.index ["ownerable_id", "ownerable_type", "vin_code"], name: "index_cars_on_ownerable_id_and_ownerable_type_and_vin_code", unique: true
    t.index ["ownerable_type", "ownerable_id"], name: "index_cars_on_ownerable"
  end

  create_table "cities", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_cities_on_title", unique: true
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.jsonb "synonyms", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_marks_on_brand_id"
    t.index ["title"], name: "index_marks_on_title", unique: true
  end

  create_table "price_range_cells", force: :cascade do |t|
    t.bigint "price_range_id", null: false
    t.integer "from", null: false
    t.integer "to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_range_id"], name: "index_price_range_cells_on_price_range_id"
  end

  create_table "price_ranges", force: :cascade do |t|
    t.bigint "car_park_id", null: false
    t.string "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_park_id"], name: "index_price_ranges_on_car_park_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "kind", default: "S", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "temp_password"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "car_parks", "cities"
  add_foreign_key "car_parks", "users"
  add_foreign_key "cars", "marks"
  add_foreign_key "marks", "brands"
  add_foreign_key "price_range_cells", "price_ranges"
  add_foreign_key "price_ranges", "car_parks"
end
