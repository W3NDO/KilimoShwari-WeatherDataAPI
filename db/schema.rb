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

ActiveRecord::Schema.define(version: 2022_01_08_100232) do

  create_table "client_weather_data", force: :cascade do |t|
    t.string "name"
    t.string "geo_location"
    t.text "weather_data"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "policy_id"
    t.integer "counter"
    t.index ["user_id"], name: "index_client_weather_data_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "address"
    t.string "maize_variety"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "policy_id", null: false
    t.string "blockhash"
    t.index ["policy_id"], name: "index_contracts_on_policy_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "location"
    t.string "maize_variety"
    t.integer "start_date"
    t.integer "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "coordinates"
    t.index ["user_id"], name: "index_policies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "client_weather_data", "users"
  add_foreign_key "contracts", "policies"
  add_foreign_key "policies", "users"
end
