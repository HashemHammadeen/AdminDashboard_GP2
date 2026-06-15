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

ActiveRecord::Schema[8.1].define(version: 2026_05_04_210001) do
  create_schema "extensions"

  # These are extensions that must be enabled in order to support this database
  enable_extension "extensions.pg_stat_statements"
  enable_extension "extensions.pgcrypto"
  enable_extension "extensions.uuid-ossp"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vault.supabase_vault"

  create_table "public.__EFMigrationsHistory", primary_key: "migration_id", id: { type: :string, limit: 150 }, force: :cascade do |t|
    t.string "product_version", limit: 32, null: false
  end

  create_table "public.audit_log", primary_key: "log_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "action_type", limit: 100, null: false
    t.string "admin_type", limit: 20
    t.timestamptz "created_at", default: -> { "now()" }, null: false
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

  create_table "public.category", primary_key: "category_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.text "description", null: false
    t.integer "display_order", default: 0, null: false
    t.string "icon_url", limit: 512, null: false
    t.uuid "mall_id", null: false
    t.string "name", limit: 200, null: false
    t.index ["mall_id"], name: "ix_category_mall_id"
    t.index ["name"], name: "ix_category_name", unique: true
  end

  create_table "public.earn_transaction", primary_key: "earn_id", id: :uuid, default: nil, force: :cascade do |t|
    t.decimal "PurchaseAmount", precision: 10, scale: 2, null: false
    t.string "PurchaseCurrency", limit: 3, null: false
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.integer "points_earned", null: false
    t.uuid "shop_id", null: false
    t.string "transaction_ref", limit: 200
    t.uuid "user_id", null: false
    t.index ["created_at"], name: "ix_earn_transaction_created_at"
    t.index ["shop_id"], name: "ix_earn_transaction_shop_id"
    t.index ["user_id"], name: "ix_earn_transaction_user_id"
  end

  create_table "public.mall", primary_key: "mall_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "cover_image_url", limit: 512
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.string "location", limit: 500
    t.string "logo_url", limit: 512
    t.string "name", limit: 200, null: false
    t.index ["name"], name: "ix_mall_name", unique: true
  end

  create_table "public.mall_admin", primary_key: "mall_admin_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.string "email", limit: 256, null: false
    t.uuid "mall_id", null: false
    t.string "name", limit: 200, null: false
    t.text "password_hash", null: false
    t.string "phone", limit: 20, null: false
    t.index ["email"], name: "ix_mall_admin_email", unique: true
    t.index ["mall_id"], name: "ix_mall_admin_mall_id"
    t.index ["phone"], name: "ix_mall_admin_phone", unique: true
  end

  create_table "public.mall_admin_password_reset_request", primary_key: "request_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.index ["mall_admin_id"], name: "ix_mall_admin_password_reset_request_mall_admin_id", unique: true
    t.index ["token_hash"], name: "ix_mall_admin_password_reset_request_token_hash", unique: true
  end

  create_table "public.mall_admin_session", primary_key: "session_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.timestamptz "expires_at_utc", null: false
    t.uuid "mall_admin_id", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.index ["mall_admin_id"], name: "ix_mall_admin_session_mall_admin_id"
    t.index ["refresh_token_hash"], name: "ix_mall_admin_session_refresh_token_hash", unique: true
  end

  create_table "public.offer", primary_key: "offer_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.text "description", null: false
    t.timestamptz "end_date", null: false
    t.string "image_url", limit: 512, null: false
    t.boolean "is_active", default: true, null: false
    t.string "name", limit: 200, null: false
    t.string "reward_type", limit: 30, null: false
    t.jsonb "reward_value", null: false
    t.uuid "shop_id", null: false
    t.timestamptz "start_date", null: false
    t.index ["is_active"], name: "ix_offer_is_active"
    t.index ["shop_id"], name: "ix_offer_shop_id"
    t.index ["start_date"], name: "ix_offer_start_date"
  end

  create_table "public.offer_redemption", primary_key: "redemption_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "confirmed_at"
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.uuid "offer_id", null: false
    t.uuid "qr_id"
    t.uuid "shop_id", null: false
    t.integer "status", default: 1, null: false
    t.uuid "user_id", null: false
    t.index ["offer_id"], name: "ix_offer_redemption_offer_id"
    t.index ["shop_id"], name: "ix_offer_redemption_shop_id"
    t.index ["status"], name: "ix_offer_redemption_status"
    t.index ["user_id", "offer_id"], name: "ix_offer_redemption_user_id_offer_id"
    t.index ["user_id"], name: "ix_offer_redemption_user_id"
  end

  create_table "public.password_reset_request", primary_key: "request_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "expires_at_utc", null: false
    t.string "token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["token_hash"], name: "ix_password_reset_request_token_hash", unique: true
    t.index ["user_id"], name: "ix_password_reset_request_user_id", unique: true
  end

  create_table "public.qr_code", primary_key: "qr_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "expires_at", null: false
    t.jsonb "qr_code_data", null: false
    t.uuid "shop_id"
    t.uuid "user_id"
    t.index ["expires_at"], name: "ix_qr_code_expires_at"
    t.index ["shop_id"], name: "ix_qr_code_shop_id"
    t.index ["user_id"], name: "ix_qr_code_user_id"
  end

  create_table "public.receipt", primary_key: "receipt_id", id: :uuid, default: nil, force: :cascade do |t|
    t.decimal "Amount", precision: 12, scale: 2, null: false
    t.string "Currency", limit: 3, null: false
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.string "image_hash", limit: 64, null: false
    t.jsonb "receipt_details", null: false
    t.string "receipt_path", limit: 512, null: false
    t.uuid "shop_id", null: false
    t.string "status", limit: 20, null: false
    t.uuid "user_id", null: false
    t.index ["image_hash"], name: "ix_receipt_image_hash", unique: true
    t.index ["shop_id"], name: "ix_receipt_shop_id"
    t.index ["status"], name: "ix_receipt_status"
    t.index ["user_id"], name: "ix_receipt_user_id"
  end

  create_table "public.redeem_transaction", primary_key: "redeem_id", id: :uuid, default: nil, force: :cascade do |t|
    t.decimal "DiscountAmount", precision: 10, scale: 2, null: false
    t.string "DiscountCurrency", limit: 3, null: false
    t.decimal "applied_points_to_currency_ratio", precision: 12, scale: 6, default: "0.0", null: false
    t.timestamptz "completed_at"
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.integer "points_used", null: false
    t.uuid "shop_id", null: false
    t.string "status", limit: 20, null: false
    t.uuid "user_id", null: false
    t.string "verification_code", limit: 6, null: false
    t.index ["shop_id"], name: "ix_redeem_transaction_shop_id"
    t.index ["status"], name: "ix_redeem_transaction_status"
    t.index ["user_id"], name: "ix_redeem_transaction_user_id"
    t.index ["verification_code"], name: "ix_redeem_transaction_verification_code", unique: true
  end

  create_table "public.shop", primary_key: "shop_id", id: :uuid, default: nil, force: :cascade do |t|
    t.text "bio", null: false
    t.uuid "category_id", null: false
    t.string "cover_image_url", limit: 512, null: false
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.boolean "is_active", default: true, null: false
    t.string "logo_url", limit: 512, null: false
    t.uuid "mall_id", null: false
    t.string "name", limit: 200, null: false
    t.jsonb "social_links"
    t.string "website_url", limit: 512
    t.index ["category_id"], name: "ix_shop_category_id"
    t.index ["mall_id"], name: "ix_shop_mall_id"
    t.index ["name"], name: "ix_shop_name", unique: true
  end

  create_table "public.shop_admin", primary_key: "shop_admin_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "Email", limit: 256, null: false
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.boolean "is_active", default: true, null: false
    t.string "name", limit: 200, null: false
    t.text "password_hash", null: false
    t.string "phone", limit: 20, null: false
    t.string "role", limit: 20, default: "Staff", null: false
    t.uuid "shop_id", null: false
    t.index ["Email"], name: "ix_shop_admin_email", unique: true
    t.index ["phone"], name: "ix_shop_admin_phone", unique: true
    t.index ["shop_id"], name: "ix_shop_admin_shop_id"
  end

  create_table "public.shop_admin_password_reset_request", primary_key: "request_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "expires_at_utc", null: false
    t.uuid "shop_admin_id", null: false
    t.string "token_hash", limit: 128, null: false
    t.index ["shop_admin_id"], name: "ix_shop_admin_password_reset_request_shop_admin_id", unique: true
    t.index ["token_hash"], name: "ix_shop_admin_password_reset_request_token_hash", unique: true
  end

  create_table "public.shop_admin_session", primary_key: "session_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.timestamptz "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "shop_admin_id", null: false
    t.index ["refresh_token_hash"], name: "ix_shop_admin_session_refresh_token_hash", unique: true
    t.index ["shop_admin_id"], name: "ix_shop_admin_session_shop_admin_id"
  end

  create_table "public.shop_points_wallet", primary_key: "shop_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "last_updated", default: -> { "now()" }, null: false
    t.integer "points_received", default: 0, null: false
  end

  create_table "public.stamp", primary_key: "stamp_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.text "description", null: false
    t.timestamptz "end_date", null: false
    t.string "image_url", limit: 512, null: false
    t.boolean "is_active", default: true, null: false
    t.string "name", limit: 200, null: false
    t.string "reward_type", limit: 30, null: false
    t.uuid "shop_id", null: false
    t.string "stamp_icon_url", limit: 512, null: false
    t.integer "stamps_required", null: false
    t.timestamptz "start_date", null: false
    t.index ["is_active"], name: "ix_stamp_is_active"
    t.index ["shop_id"], name: "ix_stamp_shop_id"
  end

  create_table "public.stamp_redemption", primary_key: "redemption_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.uuid "qr_id"
    t.uuid "shop_id", null: false
    t.uuid "stamp_id", null: false
    t.uuid "user_id", null: false
    t.index ["qr_id"], name: "ix_stamp_redemption_qr_id", unique: true
    t.index ["shop_id"], name: "ix_stamp_redemption_shop_id"
    t.index ["stamp_id"], name: "ix_stamp_redemption_stamp_id"
    t.index ["user_id", "stamp_id"], name: "ix_stamp_redemption_user_id_stamp_id"
    t.index ["user_id"], name: "ix_stamp_redemption_user_id"
  end

  create_table "public.stamp_transaction", primary_key: "stamp_tx_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.uuid "redemption_ref"
    t.uuid "shop_id", null: false
    t.uuid "stamp_program_id", null: false
    t.integer "stamps_count", null: false
    t.string "type", limit: 20, null: false
    t.uuid "user_id", null: false
    t.index ["redemption_ref"], name: "ix_stamp_transaction_redemption_ref"
    t.index ["shop_id"], name: "ix_stamp_transaction_shop_id"
    t.index ["stamp_program_id"], name: "ix_stamp_transaction_stamp_program_id"
    t.index ["user_id"], name: "ix_stamp_transaction_user_id"
  end

  create_table "public.system_config", primary_key: "config_id", id: :uuid, default: nil, force: :cascade do |t|
    t.decimal "earn_points_per_currency", precision: 10, scale: 2, null: false
    t.uuid "mall_id", null: false
    t.integer "min_redemption_threshold", null: false
    t.decimal "points_to_currency_ratio", precision: 10, scale: 4, null: false
    t.timestamptz "updated_at", default: -> { "now()" }, null: false
    t.uuid "updated_by_admin_id", null: false
    t.index ["mall_id"], name: "ix_system_config_mall_id", unique: true
    t.index ["updated_by_admin_id"], name: "ix_system_config_updated_by_admin_id"
  end

  create_table "public.tier", primary_key: "tier_id", id: :uuid, default: nil, force: :cascade do |t|
    t.jsonb "benefits"
    t.string "color_hex", limit: 7
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.string "icon_url", limit: 512, null: false
    t.string "name", limit: 100, null: false
    t.integer "points_required", default: 0, null: false
    t.integer "tier_order", null: false
    t.index ["name"], name: "ix_tier_name", unique: true
    t.index ["tier_order"], name: "ix_tier_tier_order", unique: true
  end

  create_table "public.user", primary_key: "user_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.string "email", limit: 256, null: false
    t.string "first_name", limit: 100, null: false
    t.string "gender", limit: 10, null: false
    t.string "last_name", limit: 100, null: false
    t.text "password_hash", null: false
    t.string "phone", limit: 20, null: false
    t.string "profile_image_url", limit: 512
    t.uuid "tier_id", null: false
    t.index ["email"], name: "ix_user_email", unique: true
    t.index ["phone"], name: "ix_user_phone", unique: true
    t.index ["tier_id"], name: "ix_user_tier_id"
  end

  create_table "public.user_points_balance", primary_key: "user_points_balance_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "last_updated", default: -> { "now()" }, null: false
    t.integer "lifetime_points", default: 0, null: false
    t.integer "total_points", default: 0, null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "ix_user_points_balance_user_id", unique: true
  end

  create_table "public.user_session", primary_key: "session_id", id: :uuid, default: nil, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.timestamptz "expires_at_utc", null: false
    t.string "refresh_token_hash", limit: 128, null: false
    t.uuid "user_id", null: false
    t.index ["refresh_token_hash"], name: "ix_user_session_refresh_token_hash", unique: true
    t.index ["user_id"], name: "ix_user_session_user_id"
  end

  create_table "public.user_stamp_card", primary_key: ["user_id", "stamp_id"], force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "now()" }, null: false
    t.boolean "is_completed", default: false, null: false
    t.timestamptz "last_transaction", null: false
    t.uuid "stamp_id", null: false
    t.integer "stamps_counter", default: 0, null: false
    t.uuid "user_id", null: false
    t.index ["stamp_id"], name: "ix_user_stamp_card_stamp_id"
    t.index ["user_id"], name: "ix_user_stamp_card_user_id"
  end

  add_foreign_key "public.audit_log", "public.mall_admin", primary_key: "mall_admin_id", name: "fk_audit_log_mall_admin_mall_admin_id", on_delete: :nullify
  add_foreign_key "public.audit_log", "public.shop", primary_key: "shop_id", name: "fk_audit_log_shop_shop_id", on_delete: :nullify
  add_foreign_key "public.audit_log", "public.shop_admin", primary_key: "shop_admin_id", name: "fk_audit_log_shop_admin_shop_admin_id", on_delete: :nullify
  add_foreign_key "public.audit_log", "public.user", primary_key: "user_id", name: "fk_audit_log_user_user_id", on_delete: :nullify
  add_foreign_key "public.category", "public.mall", primary_key: "mall_id", name: "fk_category_mall_mall_id", on_delete: :cascade
  add_foreign_key "public.earn_transaction", "public.shop", primary_key: "shop_id", name: "fk_earn_transaction_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.earn_transaction", "public.user", primary_key: "user_id", name: "fk_earn_transaction_user_user_id", on_delete: :restrict
  add_foreign_key "public.mall_admin", "public.mall", primary_key: "mall_id", name: "fk_mall_admin_mall_mall_id", on_delete: :cascade
  add_foreign_key "public.mall_admin_password_reset_request", "public.mall_admin", primary_key: "mall_admin_id", name: "fk_mall_admin_password_reset_request_mall_admin_mall_admin_id", on_delete: :cascade
  add_foreign_key "public.mall_admin_session", "public.mall_admin", primary_key: "mall_admin_id", name: "fk_mall_admin_session_mall_admin_mall_admin_id", on_delete: :cascade
  add_foreign_key "public.offer", "public.shop", primary_key: "shop_id", name: "fk_offer_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.offer_redemption", "public.offer", primary_key: "offer_id", name: "fk_offer_redemption_offer_offer_id", on_delete: :cascade
  add_foreign_key "public.offer_redemption", "public.shop", primary_key: "shop_id", name: "fk_offer_redemption_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.offer_redemption", "public.user", primary_key: "user_id", name: "fk_offer_redemption_user_user_id", on_delete: :restrict
  add_foreign_key "public.password_reset_request", "public.user", primary_key: "user_id", name: "fk_password_reset_request_user_user_id", on_delete: :cascade
  add_foreign_key "public.qr_code", "public.shop", primary_key: "shop_id", name: "fk_qr_code_shop_shop_id", on_delete: :cascade
  add_foreign_key "public.qr_code", "public.user", primary_key: "user_id", name: "fk_qr_code_user_user_id", on_delete: :cascade
  add_foreign_key "public.receipt", "public.shop", primary_key: "shop_id", name: "fk_receipt_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.receipt", "public.user", primary_key: "user_id", name: "fk_receipt_user_user_id", on_delete: :restrict
  add_foreign_key "public.redeem_transaction", "public.shop", primary_key: "shop_id", name: "fk_redeem_transaction_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.redeem_transaction", "public.user", primary_key: "user_id", name: "fk_redeem_transaction_user_user_id", on_delete: :restrict
  add_foreign_key "public.shop", "public.category", primary_key: "category_id", name: "fk_shop_category_category_id", on_delete: :restrict
  add_foreign_key "public.shop", "public.mall", primary_key: "mall_id", name: "fk_shop_mall_mall_id", on_delete: :restrict
  add_foreign_key "public.shop_admin", "public.shop", primary_key: "shop_id", name: "fk_shop_admin_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.shop_admin_password_reset_request", "public.shop_admin", primary_key: "shop_admin_id", name: "fk_shop_admin_password_reset_request_shop_admin_shop_admin_id", on_delete: :cascade
  add_foreign_key "public.shop_admin_session", "public.shop_admin", primary_key: "shop_admin_id", name: "fk_shop_admin_session_shop_admin_shop_admin_id", on_delete: :cascade
  add_foreign_key "public.shop_points_wallet", "public.shop", primary_key: "shop_id", name: "fk_shop_points_wallet_shop_shop_id", on_delete: :cascade
  add_foreign_key "public.stamp", "public.shop", primary_key: "shop_id", name: "fk_stamp_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.stamp_redemption", "public.qr_code", column: "qr_id", primary_key: "qr_id", name: "fk_stamp_redemption_qr_code_qr_id", on_delete: :restrict
  add_foreign_key "public.stamp_redemption", "public.shop", primary_key: "shop_id", name: "fk_stamp_redemption_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.stamp_redemption", "public.stamp", primary_key: "stamp_id", name: "fk_stamp_redemption_stamp_stamp_id", on_delete: :restrict
  add_foreign_key "public.stamp_redemption", "public.user", primary_key: "user_id", name: "fk_stamp_redemption_user_user_id", on_delete: :restrict
  add_foreign_key "public.stamp_transaction", "public.qr_code", column: "redemption_ref", primary_key: "qr_id", name: "fk_stamp_transaction_qr_code_redemption_ref", on_delete: :restrict
  add_foreign_key "public.stamp_transaction", "public.shop", primary_key: "shop_id", name: "fk_stamp_transaction_shop_shop_id", on_delete: :restrict
  add_foreign_key "public.stamp_transaction", "public.stamp", column: "stamp_program_id", primary_key: "stamp_id", name: "fk_stamp_transaction_stamp_stamp_program_id", on_delete: :restrict
  add_foreign_key "public.stamp_transaction", "public.user", primary_key: "user_id", name: "fk_stamp_transaction_user_user_id", on_delete: :restrict
  add_foreign_key "public.system_config", "public.mall", primary_key: "mall_id", name: "fk_system_config_mall_mall_id", on_delete: :restrict
  add_foreign_key "public.system_config", "public.mall_admin", column: "updated_by_admin_id", primary_key: "mall_admin_id", name: "fk_system_config_mall_admin_updated_by_admin_id", on_delete: :restrict
  add_foreign_key "public.user", "public.tier", primary_key: "tier_id", name: "fk_user_tier_tier_id", on_delete: :restrict
  add_foreign_key "public.user_points_balance", "public.user", primary_key: "user_id", name: "fk_user_points_balance_user_user_id", on_delete: :cascade
  add_foreign_key "public.user_session", "public.user", primary_key: "user_id", name: "fk_user_session_user_user_id", on_delete: :cascade
  add_foreign_key "public.user_stamp_card", "public.stamp", primary_key: "stamp_id", name: "fk_user_stamp_card_stamp_stamp_id", on_delete: :restrict
  add_foreign_key "public.user_stamp_card", "public.user", primary_key: "user_id", name: "fk_user_stamp_card_user_user_id", on_delete: :restrict

end
