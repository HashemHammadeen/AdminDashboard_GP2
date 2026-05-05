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

ActiveRecord::Schema[8.1].define(version: 2026_05_05_000000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "audit_log", primary_key: "log_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "action_type", null: false
    t.datetime "created_at", null: false
    t.uuid "mall_admin_id"
    t.jsonb "metadata"
    t.integer "points"
    t.uuid "shop_admin_id"
    t.uuid "shop_id"
    t.uuid "user_id"
    t.index ["created_at"], name: "ix_audit_log_created_at"
    t.index ["mall_admin_id"], name: "ix_audit_log_mall_admin_id"
    t.index ["shop_admin_id"], name: "ix_audit_log_shop_admin_id"
    t.index ["shop_id"], name: "ix_audit_log_shop_id"
    t.index ["user_id"], name: "ix_audit_log_user_id"
  end

  create_table "category", primary_key: "category_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.integer "display_order", default: 0, null: false
    t.string "icon_url", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.index ["mall_id"], name: "ix_category_mall_id"
  end

  create_table "earn_transaction", primary_key: "earn_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "PurchaseAmount", precision: 10, scale: 2
    t.string "PurchaseCurrency", limit: 3, default: "JOD", null: false
    t.datetime "created_at", null: false
    t.integer "points_earned"
    t.uuid "shop_id", null: false
    t.string "transaction_ref"
    t.uuid "user_id", null: false
    t.index ["created_at"], name: "ix_earn_transaction_created_at"
    t.index ["shop_id"], name: "ix_earn_transaction_shop_id"
    t.index ["user_id"], name: "ix_earn_transaction_user_id"
  end

  create_table "mall", primary_key: "mall_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cover_image_url"
    t.datetime "created_at", null: false
    t.string "location"
    t.string "logo_url"
    t.string "name", null: false
  end

  create_table "mall_admin", primary_key: "mall_admin_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.text "password_hash", default: "", null: false
    t.string "phone", null: false
    t.index ["email"], name: "ix_mall_admin_email", unique: true
    t.index ["mall_id"], name: "ix_mall_admin_mall_id"
    t.index ["phone"], name: "ix_mall_admin_phone", unique: true
  end

  create_table "mall_admin_password_reset_request", primary_key: "request_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.index ["mall_admin_id"], name: "ix_mall_admin_password_reset_request_mall_admin_id", unique: true
    t.index ["token_hash"], name: "ix_mall_admin_password_reset_request_token_hash", unique: true
  end

  create_table "mall_admin_session", primary_key: "session_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.index ["mall_admin_id"], name: "ix_mall_admin_session_mall_admin_id"
    t.index ["refresh_token_hash"], name: "ix_mall_admin_session_refresh_token_hash", unique: true
  end

  create_table "offer", primary_key: "offer_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "end_date"
    t.string "image_url", null: false
    t.boolean "is_active", default: true
    t.string "name", null: false
    t.string "reward_type", null: false
    t.jsonb "reward_value"
    t.uuid "shop_id", null: false
    t.datetime "start_date"
    t.index ["is_active"], name: "ix_offer_is_active"
    t.index ["shop_id"], name: "ix_offer_shop_id"
    t.index ["start_date"], name: "ix_offer_start_date"
  end

  create_table "offer_redemption", primary_key: "redemption_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "offer_id", null: false
    t.uuid "redemption_ref"
    t.uuid "shop_id", null: false
    t.uuid "user_id", null: false
    t.index ["offer_id"], name: "ix_offer_redemption_offer_id"
    t.index ["redemption_ref"], name: "ix_offer_redemption_redemption_ref"
    t.index ["shop_id"], name: "ix_offer_redemption_shop_id"
    t.index ["user_id"], name: "ix_offer_redemption_user_id"
  end

  create_table "password_reset_request", primary_key: "request_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "expires_at_utc", null: false
    t.string "token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["token_hash"], name: "ix_password_reset_request_token_hash", unique: true
    t.index ["user_id"], name: "ix_password_reset_request_user_id", unique: true
  end

  create_table "qr_code", primary_key: "qr_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "expires_at"
    t.jsonb "qr_code_data"
    t.uuid "shop_id"
    t.uuid "user_id"
    t.index ["expires_at"], name: "ix_qr_code_expires_at"
    t.index ["shop_id"], name: "ix_qr_code_shop_id"
    t.index ["user_id"], name: "ix_qr_code_user_id"
  end

  create_table "receipt", primary_key: "receipt_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "Amount", precision: 12, scale: 2, null: false
    t.string "Currency", limit: 3, default: "JOD", null: false
    t.datetime "created_at", null: false
    t.jsonb "receipt_details", null: false
    t.string "receipt_path", null: false
    t.uuid "shop_id", null: false
    t.string "status", default: "pending"
    t.uuid "user_id", null: false
    t.index ["shop_id"], name: "ix_receipt_shop_id"
    t.index ["status"], name: "ix_receipt_status"
    t.index ["user_id"], name: "ix_receipt_user_id"
  end

  create_table "redeem_transaction", primary_key: "redeem_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "DiscountAmount", precision: 10, scale: 2, null: false
    t.string "DiscountCurrency", limit: 3, default: "JOD", null: false
    t.decimal "applied_points_to_currency_ratio", precision: 12, scale: 6, default: "0.0"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.integer "points_used", null: false
    t.uuid "shop_id", null: false
    t.string "status", default: "pending"
    t.uuid "user_id", null: false
    t.string "verification_code", limit: 6, null: false
    t.index ["shop_id"], name: "ix_redeem_transaction_shop_id"
    t.index ["status"], name: "ix_redeem_transaction_status"
    t.index ["user_id"], name: "ix_redeem_transaction_user_id"
    t.index ["verification_code"], name: "ix_redeem_transaction_verification_code", unique: true
  end

  create_table "shop", primary_key: "shop_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "bio", null: false
    t.uuid "category_id", null: false
    t.string "cover_image_url", null: false
    t.datetime "created_at", null: false
    t.boolean "is_active", default: true
    t.string "logo_url", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.jsonb "social_links"
    t.string "website_url"
    t.index ["category_id"], name: "ix_shop_category_id"
    t.index ["mall_id"], name: "ix_shop_mall_id"
    t.index ["name"], name: "ix_shop_name", unique: true
  end

  create_table "shop_admin", primary_key: "shop_admin_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.boolean "is_active", default: true
    t.string "name", null: false
    t.text "password_hash", default: "", null: false
    t.string "phone", null: false
    t.uuid "shop_id", null: false
    t.index ["email"], name: "ix_shop_admin_email", unique: true
    t.index ["phone"], name: "ix_shop_admin_phone", unique: true
    t.index ["shop_id"], name: "ix_shop_admin_shop_id"
  end

  create_table "shop_admin_password_reset_request", primary_key: "request_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "expires_at_utc", null: false
    t.uuid "shop_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.index ["shop_admin_id"], name: "ix_shop_admin_password_reset_request_shop_admin_id", unique: true
    t.index ["token_hash"], name: "ix_shop_admin_password_reset_request_token_hash", unique: true
  end

  create_table "shop_admin_session", primary_key: "session_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "shop_admin_id", null: false
    t.index ["refresh_token_hash"], name: "ix_shop_admin_session_refresh_token_hash", unique: true
    t.index ["shop_admin_id"], name: "ix_shop_admin_session_shop_admin_id"
  end

  create_table "shop_points_wallet", id: false, force: :cascade do |t|
    t.datetime "last_updated", default: -> { "now()" }, null: false
    t.integer "points_received", default: 0
    t.uuid "shop_id", null: false
    t.index ["shop_id"], name: "ix_shop_points_wallet_shop_id", unique: true
  end

  create_table "stamp", primary_key: "stamp_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "end_date"
    t.string "image_url", null: false
    t.boolean "is_active", default: true
    t.string "name", null: false
    t.string "reward_type", null: false
    t.uuid "shop_id", null: false
    t.string "stamp_icon_url", null: false
    t.integer "stamps_required", null: false
    t.datetime "start_date"
    t.index ["is_active"], name: "ix_stamp_is_active"
    t.index ["shop_id"], name: "ix_stamp_shop_id"
  end

  create_table "stamp_redemption", primary_key: "redemption_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "redemption_ref"
    t.uuid "shop_id", null: false
    t.uuid "stamp_id", null: false
    t.uuid "user_id", null: false
    t.index ["redemption_ref"], name: "ix_stamp_redemption_redemption_ref"
    t.index ["shop_id"], name: "ix_stamp_redemption_shop_id"
    t.index ["stamp_id"], name: "ix_stamp_redemption_stamp_id"
    t.index ["user_id"], name: "ix_stamp_redemption_user_id"
  end

  create_table "stamp_transaction", primary_key: "stamp_tx_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "redemption_ref"
    t.uuid "shop_id", null: false
    t.uuid "stamp_program_id", null: false
    t.integer "stamps_count", default: 1, null: false
    t.string "type", null: false
    t.uuid "user_id", null: false
    t.index ["redemption_ref"], name: "ix_stamp_transaction_redemption_ref"
    t.index ["shop_id"], name: "ix_stamp_transaction_shop_id"
    t.index ["stamp_program_id"], name: "ix_stamp_transaction_stamp_program_id"
    t.index ["user_id"], name: "ix_stamp_transaction_user_id"
  end

  create_table "system_config", primary_key: "config_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "earn_points_per_currency", precision: 10, scale: 2, default: "1.0"
    t.uuid "mall_id", null: false
    t.integer "min_redemption_threshold", default: 100
    t.decimal "points_to_currency_ratio", precision: 10, scale: 4, default: "0.01"
    t.datetime "updated_at", null: false
    t.uuid "updated_by_admin_id", null: false
    t.index ["mall_id"], name: "ix_system_config_mall_id", unique: true
  end

  create_table "tier", primary_key: "tier_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "benefits"
    t.string "color_hex"
    t.datetime "created_at", null: false
    t.string "icon_url", null: false
    t.string "name", null: false
    t.integer "points_required", default: 0
    t.integer "tier_order"
    t.index ["name"], name: "ix_tier_name", unique: true
    t.index ["tier_order"], name: "ix_tier_tier_order", unique: true
  end

  create_table "user", primary_key: "user_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "gender", null: false
    t.string "last_name", null: false
    t.text "password_hash", null: false
    t.string "phone", null: false
    t.string "profile_image_url"
    t.uuid "tier_id", null: false
    t.index ["email"], name: "ix_user_email", unique: true
    t.index ["phone"], name: "ix_user_phone", unique: true
    t.index ["tier_id"], name: "ix_user_tier_id"
  end

  create_table "user_points_balance", primary_key: "user_points_balance_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "lifetime_points", default: 0
    t.integer "total_points", default: 0
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "ix_user_points_balance_user_id", unique: true
  end

  create_table "user_session", primary_key: "session_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["refresh_token_hash"], name: "ix_user_session_refresh_token_hash", unique: true
    t.index ["user_id"], name: "ix_user_session_user_id"
  end

  create_table "user_stamp_card", id: false, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_completed", default: false
    t.datetime "last_transaction"
    t.uuid "stamp_id", null: false
    t.integer "stamps_counter", default: 0
    t.uuid "user_id", null: false
    t.index ["stamp_id"], name: "ix_user_stamp_card_stamp_id"
    t.index ["user_id", "stamp_id"], name: "ix_user_stamp_card_user_id_stamp_id", unique: true
    t.index ["user_id"], name: "ix_user_stamp_card_user_id"
  end

  add_foreign_key "audit_log", "mall_admin", primary_key: "mall_admin_id"
  add_foreign_key "audit_log", "shop", primary_key: "shop_id"
  add_foreign_key "audit_log", "shop_admin", primary_key: "shop_admin_id"
  add_foreign_key "audit_log", "user", primary_key: "user_id"
  add_foreign_key "category", "mall", primary_key: "mall_id", on_delete: :cascade
  add_foreign_key "earn_transaction", "shop", primary_key: "shop_id"
  add_foreign_key "earn_transaction", "user", primary_key: "user_id"
  add_foreign_key "mall_admin", "mall", primary_key: "mall_id"
  add_foreign_key "mall_admin_password_reset_request", "mall_admin", primary_key: "mall_admin_id", on_delete: :cascade
  add_foreign_key "mall_admin_session", "mall_admin", primary_key: "mall_admin_id", on_delete: :cascade
  add_foreign_key "offer", "shop", primary_key: "shop_id"
  add_foreign_key "offer_redemption", "offer", primary_key: "offer_id"
  add_foreign_key "offer_redemption", "shop", primary_key: "shop_id"
  add_foreign_key "offer_redemption", "user", primary_key: "user_id"
  add_foreign_key "password_reset_request", "user", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "qr_code", "shop", primary_key: "shop_id"
  add_foreign_key "qr_code", "user", primary_key: "user_id"
  add_foreign_key "receipt", "shop", primary_key: "shop_id"
  add_foreign_key "receipt", "user", primary_key: "user_id"
  add_foreign_key "redeem_transaction", "shop", primary_key: "shop_id"
  add_foreign_key "redeem_transaction", "user", primary_key: "user_id"
  add_foreign_key "shop", "category", primary_key: "category_id"
  add_foreign_key "shop", "mall", primary_key: "mall_id"
  add_foreign_key "shop_admin", "shop", primary_key: "shop_id"
  add_foreign_key "shop_admin_password_reset_request", "shop_admin", primary_key: "shop_admin_id", on_delete: :cascade
  add_foreign_key "shop_admin_session", "shop_admin", primary_key: "shop_admin_id", on_delete: :cascade
  add_foreign_key "shop_points_wallet", "shop", primary_key: "shop_id", on_delete: :cascade
  add_foreign_key "stamp", "shop", primary_key: "shop_id"
  add_foreign_key "stamp_redemption", "shop", primary_key: "shop_id"
  add_foreign_key "stamp_redemption", "stamp", primary_key: "stamp_id"
  add_foreign_key "stamp_redemption", "user", primary_key: "user_id"
  add_foreign_key "stamp_transaction", "qr_code", column: "redemption_ref", primary_key: "qr_id"
  add_foreign_key "stamp_transaction", "shop", primary_key: "shop_id"
  add_foreign_key "stamp_transaction", "stamp", column: "stamp_program_id", primary_key: "stamp_id"
  add_foreign_key "stamp_transaction", "user", primary_key: "user_id"
  add_foreign_key "system_config", "mall", primary_key: "mall_id"
  add_foreign_key "system_config", "mall_admin", column: "updated_by_admin_id", primary_key: "mall_admin_id"
  add_foreign_key "user", "tier", primary_key: "tier_id"
  add_foreign_key "user_points_balance", "user", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "user_session", "user", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "user_stamp_card", "stamp", primary_key: "stamp_id"
  add_foreign_key "user_stamp_card", "user", primary_key: "user_id"
end
