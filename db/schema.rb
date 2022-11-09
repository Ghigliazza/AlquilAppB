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

ActiveRecord::Schema[7.0].define(version: 2022_11_09_134125) do
  create_table "cards", force: :cascade do |t|
    t.integer "cardNumber"
    t.date "expires"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "reports", force: :cascade do |t|
    t.text "description"
    t.string "user_id"
    t.string "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.float "balance"
    t.float "coords_x"
    t.float "coords_y"
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
