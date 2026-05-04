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

ActiveRecord::Schema[8.1].define(version: 2026_05_04_000001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "audit_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "action_type", null: false, comment: "e.g., manual_adjustment, tier_change, config_update"
    t.datetime "created_at", null: false
    t.uuid "mall_admin_id"
    t.jsonb "metadata", comment: "Extra details about the change"
    t.integer "points", comment: "The number of points changed, if applicable"
    t.uuid "shop_admin_id"
    t.uuid "shop_id"
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["created_at"], name: "ix_audit_log_created_at"
    t.index ["mall_admin_id"], name: "ix_audit_log_mall_admin_id"
    t.index ["shop_admin_id"], name: "ix_audit_log_shop_admin_id"
    t.index ["shop_id"], name: "index_audit_logs_on_shop_id"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.integer "display_order", default: 0
    t.string "icon_url", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_id"], name: "index_categories_on_mall_id"
    t.index ["mall_id"], name: "ix_category_mall_id"
  end

  create_table "earn_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "points_earned"
    t.decimal "purchase_amount", precision: 10, scale: 2
    t.string "purchase_currency", limit: 3, default: "JOD", null: false
    t.uuid "shop_id", null: false
    t.string "transaction_ref"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["created_at"], name: "ix_earn_transaction_created_at"
    t.index ["shop_id"], name: "index_earn_transactions_on_shop_id"
    t.index ["user_id"], name: "index_earn_transactions_on_user_id"
  end

  create_table "mall_admin_password_reset_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.datetime "updated_at", null: false
    t.index ["mall_admin_id"], name: "index_mall_admin_password_reset_requests_on_mall_admin_id"
    t.index ["mall_admin_id"], name: "ix_mall_admin_password_reset_request_mall_admin_id", unique: true
    t.index ["token_hash"], name: "ix_mall_admin_password_reset_request_token_hash", unique: true
  end

  create_table "mall_admin_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.index ["mall_admin_id"], name: "index_mall_admin_sessions_on_mall_admin_id"
    t.index ["mall_admin_id"], name: "ix_mall_admin_session_mall_admin_id"
    t.index ["refresh_token_hash"], name: "ix_mall_admin_session_refresh_token_hash", unique: true
  end

  create_table "mall_admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.text "password_hash", default: "", null: false
    t.string "phone", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mall_admins_on_email", unique: true
    t.index ["mall_id"], name: "index_mall_admins_on_mall_id"
    t.index ["phone"], name: "index_mall_admins_on_phone", unique: true
  end

  create_table "malls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cover_image_url"
    t.datetime "created_at", null: false
    t.string "location"
    t.string "logo_url"
    t.string "mall_name", null: false
    t.string "subdomain"
    t.datetime "updated_at", null: false
    t.index ["mall_name"], name: "index_malls_on_mall_name", unique: true
    t.index ["subdomain"], name: "index_malls_on_subdomain", unique: true
  end

  create_table "offer_redemptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "offer_id", null: false
    t.uuid "receipt_id"
    t.uuid "shop_id", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["offer_id"], name: "index_offer_redemptions_on_offer_id"
    t.index ["receipt_id"], name: "index_offer_redemptions_on_receipt_id"
    t.index ["shop_id"], name: "index_offer_redemptions_on_shop_id"
    t.index ["user_id"], name: "index_offer_redemptions_on_user_id"
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "end_date"
    t.string "image_url", null: false
    t.boolean "is_active"
    t.string "name", null: false
    t.string "reward_type", null: false
    t.jsonb "reward_value"
    t.uuid "shop_id", null: false
    t.datetime "start_date"
    t.datetime "updated_at", null: false
    t.index ["is_active"], name: "ix_offer_is_active"
    t.index ["shop_id"], name: "index_offers_on_shop_id"
    t.index ["start_date"], name: "ix_offer_start_date"
  end

  create_table "password_reset_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "expires_at_utc", null: false
    t.string "token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["token_hash"], name: "ix_password_reset_request_token_hash", unique: true
    t.index ["user_id"], name: "index_password_reset_requests_on_user_id", unique: true
  end

  create_table "qrs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.jsonb "qr_code_data"
    t.uuid "shop_id", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["expires_at"], name: "ix_qr_code_expires_at"
    t.index ["shop_id"], name: "index_qrs_on_shop_id"
    t.index ["user_id"], name: "index_qrs_on_user_id"
  end

  create_table "receipts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.datetime "created_at", null: false
    t.string "receipt_currency", limit: 3, default: "JOD", null: false
    t.jsonb "receipt_details", null: false
    t.string "receipt_path", null: false
    t.uuid "shop_id", null: false
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["shop_id"], name: "index_receipts_on_shop_id"
    t.index ["status"], name: "ix_receipt_status"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "redeem_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "applied_points_to_currency_ratio", precision: 12, scale: 6
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.string "discount_currency", limit: 3, default: "JOD", null: false
    t.decimal "discount_value", precision: 10, scale: 2, null: false
    t.integer "points_used", null: false
    t.uuid "shop_id", null: false
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.string "verification_code", limit: 6, null: false
    t.index ["shop_id"], name: "index_redeem_transactions_on_shop_id"
    t.index ["status"], name: "ix_redeem_transaction_status"
    t.index ["user_id"], name: "index_redeem_transactions_on_user_id"
    t.index ["verification_code"], name: "ix_redeem_transaction_verification_code", unique: true
  end

  create_table "shop_admin_password_reset_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.uuid "shop_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.datetime "updated_at", null: false
    t.index ["shop_admin_id"], name: "index_shop_admin_password_reset_requests_on_shop_admin_id"
    t.index ["shop_admin_id"], name: "ix_shop_admin_password_reset_request_shop_admin_id", unique: true
    t.index ["token_hash"], name: "ix_shop_admin_password_reset_request_token_hash", unique: true
  end

  create_table "shop_admin_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "shop_admin_id", null: false
    t.index ["refresh_token_hash"], name: "ix_shop_admin_session_refresh_token_hash", unique: true
    t.index ["shop_admin_id"], name: "index_shop_admin_sessions_on_shop_admin_id"
    t.index ["shop_admin_id"], name: "ix_shop_admin_session_shop_admin_id"
  end

  create_table "shop_admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.boolean "is_active", default: true
    t.string "name", null: false
    t.text "password_hash", default: "", null: false
    t.string "phone", null: false
    t.uuid "shop_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_shop_admins_on_email", unique: true
    t.index ["phone"], name: "index_shop_admins_on_phone", unique: true
    t.index ["shop_id"], name: "index_shop_admins_on_shop_id"
  end

  create_table "shop_points_wallets", id: false, force: :cascade do |t|
    t.datetime "last_updated", default: -> { "now()" }, null: false
    t.integer "points_received", default: 0
    t.uuid "shop_id", null: false
    t.index ["shop_id"], name: "index_shop_points_wallets_on_shop_id", unique: true
  end

  create_table "shops", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "bio", null: false
    t.uuid "category_id", null: false
    t.string "cover_image_url", null: false
    t.datetime "created_at", null: false
    t.boolean "is_active", default: true
    t.string "logo_url", null: false
    t.uuid "mall_id", null: false
    t.string "name", null: false
    t.jsonb "social_links"
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["category_id"], name: "index_shops_on_category_id"
    t.index ["mall_id"], name: "index_shops_on_mall_id"
    t.index ["name"], name: "index_shops_on_name", unique: true
  end

  create_table "stamp_redemptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "qr_id", null: false
    t.uuid "shop_id", null: false
    t.uuid "stamp_id", null: false
    t.uuid "user_id", null: false
    t.index ["qr_id"], name: "index_stamp_redemptions_on_qr_id", unique: true
    t.index ["shop_id"], name: "index_stamp_redemptions_on_shop_id"
    t.index ["shop_id"], name: "ix_stamp_redemption_shop_id"
    t.index ["stamp_id"], name: "index_stamp_redemptions_on_stamp_id"
    t.index ["stamp_id"], name: "ix_stamp_redemption_stamp_id"
    t.index ["user_id", "stamp_id"], name: "ix_stamp_redemption_user_id_stamp_id"
    t.index ["user_id"], name: "index_stamp_redemptions_on_user_id"
    t.index ["user_id"], name: "ix_stamp_redemption_user_id"
  end

  create_table "stamp_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "redemption_ref"
    t.uuid "shop_id", null: false
    t.uuid "stamp_program_id", null: false
    t.integer "stamps_count", default: 1, null: false
    t.string "type", null: false, comment: "Must be 'collect' or 'redeem'"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["redemption_ref"], name: "ix_stamp_transaction_redemption_ref"
    t.index ["shop_id"], name: "index_stamp_transactions_on_shop_id"
    t.index ["stamp_program_id"], name: "index_stamp_transactions_on_stamp_program_id"
    t.index ["user_id"], name: "index_stamp_transactions_on_user_id"
  end

  create_table "stamps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "updated_at", null: false
    t.index ["is_active"], name: "ix_stamp_is_active"
    t.index ["shop_id"], name: "index_stamps_on_shop_id"
  end

  create_table "system_configs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "earn_points_per_currency", precision: 10, scale: 2, default: "1.0"
    t.uuid "mall_id", null: false
    t.integer "min_redemption_threshold", default: 100
    t.decimal "points_to_currency_ratio", precision: 10, scale: 4, default: "0.01"
    t.datetime "updated_at", null: false
    t.uuid "updated_by_admin_id", null: false
    t.index ["mall_id"], name: "index_system_configs_on_mall_id", unique: true
  end

  create_table "tiers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "benefits"
    t.string "color_hex"
    t.datetime "created_at", null: false
    t.string "icon_url", null: false
    t.string "name", null: false
    t.integer "points_required", default: 0
    t.integer "tier_order"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tiers_on_name", unique: true
    t.index ["tier_order"], name: "ix_tier_tier_order", unique: true
  end

  create_table "user_points_balances", primary_key: "user_points_balance_id", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lifetime_points", default: 0
    t.integer "total_points", default: 0
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "ix_user_points_balance_user_id", unique: true
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["refresh_token_hash"], name: "ix_user_session_refresh_token_hash", unique: true
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
    t.index ["user_id"], name: "ix_user_session_user_id"
  end

  create_table "user_stamp_cards", id: false, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_completed", default: false
    t.datetime "last_transaction"
    t.uuid "stamp_id", null: false
    t.integer "stamps_counter", default: 0
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["stamp_id"], name: "index_user_stamp_cards_on_stamp_id"
    t.index ["user_id", "stamp_id"], name: "index_user_stamp_cards_on_user_id_and_stamp_id", unique: true
    t.index ["user_id"], name: "index_user_stamp_cards_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "gender", null: false
    t.string "last_name", null: false
    t.text "password_hash", null: false
    t.string "phone", null: false
    t.string "profile_image_url"
    t.uuid "tier_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["tier_id"], name: "index_users_on_tier_id"
  end

  add_foreign_key "audit_logs", "mall_admins", on_delete: :nullify
  add_foreign_key "audit_logs", "shop_admins", on_delete: :nullify
  add_foreign_key "audit_logs", "shops"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "categories", "malls", on_delete: :cascade
  add_foreign_key "earn_transactions", "shops"
  add_foreign_key "earn_transactions", "users"
  add_foreign_key "mall_admin_password_reset_requests", "mall_admins", on_delete: :cascade
  add_foreign_key "mall_admin_sessions", "mall_admins", on_delete: :cascade
  add_foreign_key "mall_admins", "malls"
  add_foreign_key "offer_redemptions", "offers"
  add_foreign_key "offer_redemptions", "receipts"
  add_foreign_key "offer_redemptions", "shops"
  add_foreign_key "offer_redemptions", "users"
  add_foreign_key "offers", "shops"
  add_foreign_key "password_reset_requests", "users", on_delete: :cascade
  add_foreign_key "qrs", "shops"
  add_foreign_key "qrs", "users"
  add_foreign_key "receipts", "shops"
  add_foreign_key "receipts", "users"
  add_foreign_key "redeem_transactions", "shops"
  add_foreign_key "redeem_transactions", "users"
  add_foreign_key "shop_admin_password_reset_requests", "shop_admins", on_delete: :cascade
  add_foreign_key "shop_admin_sessions", "shop_admins", on_delete: :cascade
  add_foreign_key "shop_admins", "shops"
  add_foreign_key "shop_points_wallets", "shops", on_delete: :cascade
  add_foreign_key "shops", "categories"
  add_foreign_key "shops", "malls"
  add_foreign_key "stamp_redemptions", "qrs", on_delete: :restrict
  add_foreign_key "stamp_redemptions", "shops", on_delete: :restrict
  add_foreign_key "stamp_redemptions", "stamps", on_delete: :restrict
  add_foreign_key "stamp_redemptions", "users", on_delete: :restrict
  add_foreign_key "stamp_transactions", "qrs", column: "redemption_ref", on_delete: :restrict
  add_foreign_key "stamp_transactions", "shops"
  add_foreign_key "stamp_transactions", "stamps", column: "stamp_program_id", on_delete: :restrict
  add_foreign_key "stamp_transactions", "users"
  add_foreign_key "stamps", "shops"
  add_foreign_key "system_configs", "mall_admins", column: "updated_by_admin_id", on_delete: :restrict
  add_foreign_key "system_configs", "malls", on_delete: :restrict
  add_foreign_key "user_points_balances", "users", on_delete: :cascade
  add_foreign_key "user_sessions", "users", on_delete: :cascade
  add_foreign_key "user_stamp_cards", "stamps"
  add_foreign_key "user_stamp_cards", "users"
  add_foreign_key "users", "tiers"
end
