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

ActiveRecord::Schema[7.0].define(version: 2022_12_05_214826) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.integer "number"
    t.date "expires"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bankName", default: "notfound.jpg"
  end

  create_table "cars", force: :cascade do |t|
    t.string "model"
    t.string "brand"
    t.string "license"
    t.string "color"
    t.string "img_url"
    t.integer "doors"
    t.integer "seats"
    t.integer "state"
    t.boolean "engine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "fuel"
    t.string "transmission"
    t.string "description"
    t.float "coords_x"
    t.float "coords_y"
    t.float "distance"
    t.boolean "turn_on", default: false
    t.boolean "used"
  end

  create_table "fines", force: :cascade do |t|
    t.float "amount"
    t.text "motive"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.float "price"
    t.datetime "expires"
    t.integer "rent_hs"
    t.datetime "cancel"
    t.integer "rental_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started"
  end

  create_table "positions", force: :cascade do |t|
    t.float "x"
    t.float "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "cars_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.float "price"
    t.datetime "expires"
    t.integer "user_id"
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 1000
    t.float "totalPrice"
    t.integer "total_hours"
    t.float "initial_fuel"
    t.text "summary"
    t.datetime "dateCarNear"
  end

  create_table "reports", force: :cascade do |t|
    t.text "description"
    t.string "user_id"
    t.string "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
    t.integer "guilty"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "rol", default: 2
    t.string "name"
    t.string "lastName"
    t.integer "document", null: false
    t.integer "state", default: 0
    t.string "license_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "licenseNumber"
    t.date "licenseExpiration"
    t.decimal "balance", default: "0.0"
    t.float "coords_x"
    t.float "coords_y"
    t.date "birthdate"
    t.text "rejectedMessage"
    t.date "suspended_until"
    t.text "suspended_for"
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
