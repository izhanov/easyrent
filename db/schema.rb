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

ActiveRecord::Schema[7.1].define(version: 2024_05_03_084137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "additional_services", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.string "title", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["owner_type", "owner_id"], name: "index_additional_services_on_owner"
  end

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

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "booking_acceptance_appendixes", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.integer "mileage_after_rent"
    t.integer "fuel_level_after_rent"
    t.decimal "car_wash_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "fine_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "return_from_address_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_acceptance_appendixes_on_booking_id", unique: true
  end

  create_table "booking_give_out_appendixes", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.integer "mileage_before_rent"
    t.integer "fuel_level_before_rent"
    t.string "appearance_before_rent"
    t.string "technical_condition_before_rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_give_out_appendixes_on_booking_id", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.bigint "client_id", null: false
    t.bigint "offer_id", null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.datetime "actual_starts_at"
    t.datetime "actual_ends_at"
    t.string "pickup_location", null: false
    t.string "drop_off_location", null: false
    t.boolean "self_pickup", default: false
    t.boolean "self_drop_off", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "services", default: {}
    t.string "payment_method"
    t.string "number"
    t.string "status", default: "initial", null: false
    t.decimal "pledge_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "with_pledge_amount", default: false, null: false
    t.decimal "prepayment_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "prepayment_method"
    t.boolean "without_prepayment_amount"
    t.decimal "kaspi_method_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "halyk_method_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "cash_method_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "pledge_method"
    t.index ["car_id", "status", "starts_at", "ends_at"], name: "index_bookings_on_car_id_and_status_and_starts_at_and_ends_at"
    t.index ["car_id"], name: "index_bookings_on_car_id"
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["ends_at"], name: "index_bookings_on_ends_at", using: :brin
    t.index ["offer_id"], name: "index_bookings_on_offer_id"
    t.index ["starts_at"], name: "index_bookings_on_starts_at", using: :brin
  end

  create_table "brands", force: :cascade do |t|
    t.string "title", null: false
    t.jsonb "synonyms", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_brands_on_title", unique: true
  end

  create_table "car_inspections", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.date "start_at"
    t.date "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_inspections_on_car_id"
  end

  create_table "car_insurances", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.date "start_at"
    t.date "end_at"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_insurances_on_car_id"
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
    t.string "booking_prefix", limit: 4, default: "UNDF", null: false
    t.index ["booking_prefix"], name: "index_car_parks_on_booking_prefix", unique: true, where: "(booking_prefix IS NOT NULL)"
    t.index ["city_id", "business_id_number"], name: "index_car_parks_on_city_id_and_business_id_number", unique: true
    t.index ["city_id"], name: "index_car_parks_on_city_id"
    t.index ["user_id"], name: "index_car_parks_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "mark_id", null: false
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
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
    t.decimal "engine_capacity", precision: 7, scale: 2
    t.string "engine_capacity_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "technical_condition", default: "good", null: false
    t.string "appearance", default: "clean", null: false
    t.decimal "over_mileage_price", precision: 10, scale: 2
    t.index ["mark_id"], name: "index_cars_on_mark_id"
    t.index ["owner_id", "owner_type", "plate_number"], name: "index_cars_on_owner_id_and_owner_type_and_plate_number", unique: true
    t.index ["owner_id", "owner_type", "vin_code"], name: "index_cars_on_owner_id_and_owner_type_and_vin_code", unique: true
    t.index ["owner_type", "owner_id"], name: "index_cars_on_owner"
  end

  create_table "cities", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_cities_on_title", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "phone", null: false
    t.string "identification_number"
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.string "email"
    t.string "passport_number"
    t.string "driving_license"
    t.date "driving_license_issued_date"
    t.boolean "citizen", default: true
    t.string "kind", default: "individual"
    t.string "bank_account_number"
    t.string "bank_code"
    t.string "legal_address"
    t.string "signed_on_basis"
    t.string "full_name_of_the_head"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identification_number"], name: "index_clients_on_identification_number", unique: true
    t.index ["phone"], name: "index_clients_on_phone", unique: true
  end

  create_table "clients_in_users_companies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_in_users_companies_on_client_id"
    t.index ["user_id"], name: "index_clients_in_users_companies_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "consumable_logs", force: :cascade do |t|
    t.bigint "consumable_id", null: false
    t.date "date"
    t.integer "mileage_when_replacing"
    t.integer "mileage_at_next_replacing"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumable_id"], name: "index_consumable_logs_on_consumable_id"
  end

  create_table "consumables", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "title"
    t.string "description"
    t.integer "lifetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_consumables_on_car_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.date "date"
    t.string "number"
    t.decimal "total_amount"
    t.decimal "pledge_amount"
    t.decimal "prepayment_amount"
    t.decimal "services_total_amount"
    t.integer "rental_days"
    t.integer "permissible_mileage_limit"
    t.string "pledge_return_method"
    t.date "pledge_return_date"
    t.string "pledge_return_requisites"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "cost_per_day", precision: 10, scale: 2, default: "0.0"
    t.index ["booking_id", "number"], name: "index_contracts_on_booking_id_and_number", unique: true
    t.index ["booking_id"], name: "index_contracts_on_booking_id"
  end

  create_table "document_templates", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "title"
    t.string "context"
    t.text "content"
    t.string "kind"
    t.boolean "current", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_document_templates_on_owner"
  end

  create_table "documents", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.bigint "document_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "file_data"
    t.index ["document_template_id"], name: "index_documents_on_document_template_id"
    t.index ["file_data"], name: "index_documents_on_file_data", using: :gin
    t.index ["owner_type", "owner_id"], name: "index_documents_on_owner"
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

  create_table "offers", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "title", null: false
    t.jsonb "prices", default: {}, null: false
    t.integer "mileage_limit_id", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_offers_on_car_id"
    t.index ["prices"], name: "index_offers_on_prices", opclass: :jsonb_path_ops, using: :gin
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_photos_on_car_id"
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
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.string "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_price_ranges_on_owner", unique: true
  end

  create_table "rental_rule_age_restrictions", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.integer "value", default: 18, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_rental_rule_age_restrictions_on_owner", unique: true
  end

  create_table "rental_rule_driving_experiences", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_rental_rule_driving_experiences_on_owner", unique: true
  end

  create_table "rental_rule_mileage_limits", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.string "title", null: false
    t.integer "value", null: false
    t.integer "markup", default: 0, null: false
    t.integer "discount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_rental_rule_mileage_limits_on_owner"
  end

  create_table "rental_rule_minimal_periods", force: :cascade do |t|
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.integer "value", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_rental_rule_minimal_periods_on_owner"
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
    t.string "kind", default: "s", null: false
    t.string "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "temp_password"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booking_acceptance_appendixes", "bookings"
  add_foreign_key "booking_give_out_appendixes", "bookings"
  add_foreign_key "bookings", "cars"
  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "offers"
  add_foreign_key "car_inspections", "cars"
  add_foreign_key "car_insurances", "cars"
  add_foreign_key "car_parks", "cities"
  add_foreign_key "car_parks", "users"
  add_foreign_key "cars", "marks"
  add_foreign_key "clients_in_users_companies", "clients"
  add_foreign_key "clients_in_users_companies", "users"
  add_foreign_key "consumable_logs", "consumables"
  add_foreign_key "consumables", "cars"
  add_foreign_key "contracts", "bookings"
  add_foreign_key "marks", "brands"
  add_foreign_key "offers", "cars"
  add_foreign_key "photos", "cars"
  add_foreign_key "price_range_cells", "price_ranges"
end
