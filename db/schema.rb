# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_18_065925) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.integer "invite_code_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invite_code_id"], name: "index_admins_on_invite_code_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "description"
    t.boolean "is_enabled"
    t.boolean "is_subscribed"
    t.datetime "last_payment_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.datetime "token_expires"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_identities_on_admin_id"
  end

  create_table "invite_codes", force: :cascade do |t|
    t.string "code"
    t.integer "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_invite_codes_on_admin_id"
    t.index ["business_id"], name: "index_invite_codes_on_business_id"
  end

  create_table "tiers", force: :cascade do |t|
    t.integer "business_id", null: false
    t.string "name"
    t.string "color"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_count", default: 0, null: false
    t.index ["business_id"], name: "index_tiers_on_business_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "card_number"
    t.integer "tier_id", null: false
    t.boolean "is_enabled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "visit_count", default: 0, null: false
    t.index ["tier_id"], name: "index_users_on_tier_id"
  end

  create_table "visits", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_visits_on_admin_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "invite_codes"
  add_foreign_key "identities", "admins"
  add_foreign_key "invite_codes", "admins"
  add_foreign_key "invite_codes", "businesses"
  add_foreign_key "tiers", "businesses"
  add_foreign_key "users", "tiers"
  add_foreign_key "visits", "admins"
  add_foreign_key "visits", "users"
end
