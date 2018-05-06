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

ActiveRecord::Schema.define(version: 20180506013122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorization_tokens", force: :cascade do |t|
    t.string "uuid", null: false
    t.time "expiration_time", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authorization_tokens_on_user_id"
    t.index ["uuid"], name: "index_authorization_tokens_on_uuid", unique: true
  end

  create_table "data_encryption_keys", force: :cascade do |t|
    t.string "encrypted_key", null: false
    t.boolean "primary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_key_iv"
  end

  create_table "encrypted_fields", force: :cascade do |t|
    t.string "encrypted_blob"
    t.string "encrypted_blob_iv"
    t.string "encrypted_blob_salt"
    t.bigint "data_encryption_key_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_encryption_key_id"], name: "index_encrypted_fields_on_data_encryption_key_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "encrypted_phone_number_id"
    t.index ["encrypted_phone_number_id"], name: "index_users_on_encrypted_phone_number_id"
  end

  add_foreign_key "authorization_tokens", "users"
  add_foreign_key "encrypted_fields", "data_encryption_keys"
  add_foreign_key "users", "encrypted_fields", column: "encrypted_phone_number_id"
end
