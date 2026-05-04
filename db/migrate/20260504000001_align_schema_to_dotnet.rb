class AlignSchemaToDotnet < ActiveRecord::Migration[8.1]
  def change
    # =========================================================
    # 2.1 mall_admins — Remove Devise, add password_hash
    # =========================================================
    remove_index  :mall_admins, name: "index_mall_admins_on_reset_password_token", if_exists: true
    remove_column :mall_admins, :encrypted_password,    :string
    remove_column :mall_admins, :reset_password_token,  :string
    remove_column :mall_admins, :reset_password_sent_at,:datetime
    remove_column :mall_admins, :remember_created_at,   :datetime
    add_column    :mall_admins, :password_hash, :text, null: false, default: ""

    # =========================================================
    # 2.2 shop_admins — Remove Devise, add password_hash
    # =========================================================
    remove_index  :shop_admins, name: "index_shop_admins_on_reset_password_token", if_exists: true
    remove_column :shop_admins, :encrypted_password,    :string
    remove_column :shop_admins, :reset_password_token,  :string
    remove_column :shop_admins, :reset_password_sent_at,:datetime
    remove_column :shop_admins, :remember_created_at,   :datetime
    add_column    :shop_admins, :password_hash, :text, null: false, default: ""

    # =========================================================
    # 2.3 audit_logs — Replace admin_id/admin_type with separate columns
    # =========================================================
    remove_index  :audit_logs, name: "index_audit_logs_on_admin_id", if_exists: true
    remove_column :audit_logs, :admin_id,   :uuid
    remove_column :audit_logs, :admin_type, :string

    add_column :audit_logs, :mall_admin_id, :uuid
    add_column :audit_logs, :shop_admin_id, :uuid

    add_foreign_key :audit_logs, :mall_admins, column: :mall_admin_id, on_delete: :nullify
    add_foreign_key :audit_logs, :shop_admins, column: :shop_admin_id, on_delete: :nullify

    add_index :audit_logs, :mall_admin_id, name: "ix_audit_log_mall_admin_id"
    add_index :audit_logs, :shop_admin_id, name: "ix_audit_log_shop_admin_id"
    add_index :audit_logs, :created_at,    name: "ix_audit_log_created_at"

    # =========================================================
    # 2.4 categories — Rename category_name→name, add mall_id
    # =========================================================
    remove_index :categories, name: "index_categories_on_category_name", if_exists: true
    rename_column :categories, :category_name, :name
    add_reference :categories, :mall, type: :uuid, null: false,
                  foreign_key: { on_delete: :cascade },
                  default: nil
    change_column_null :categories, :description, false, ""
    change_column_null :categories, :icon_url,    false, ""
    add_index :categories, :mall_id, name: "ix_category_mall_id"

    # =========================================================
    # 2.5 earn_transactions — Add purchase_currency
    # =========================================================
    add_column :earn_transactions, :purchase_currency, :string, limit: 3, default: "JOD", null: false
    add_index  :earn_transactions, :created_at, name: "ix_earn_transaction_created_at"

    # =========================================================
    # 2.6 offers — Rename active→is_active, drop obsolete columns
    # =========================================================
    rename_column :offers, :active, :is_active
    remove_column :offers, :inactive_by_mall_admin, :boolean
    remove_column :offers, :reactivation_requested,  :boolean

    change_column_null :offers, :description, false, ""
    change_column_null :offers, :image_url,   false, ""
    change_column_null :offers, :name,        false, ""
    change_column_null :offers, :reward_type, false, ""

    add_index :offers, :is_active,  name: "ix_offer_is_active"
    add_index :offers, :start_date, name: "ix_offer_start_date"

    # =========================================================
    # 2.7 qrs — Change qr_code_data to jsonb
    # =========================================================
    change_column :qrs, :qr_code_data, :jsonb, using: "qr_code_data::jsonb"
    add_index :qrs, :expires_at, name: "ix_qr_code_expires_at"

    # =========================================================
    # 2.8 receipts — Add receipt_currency, make receipt_path NOT NULL
    # =========================================================
    add_column :receipts, :receipt_currency, :string, limit: 3, default: "JOD", null: false
    change_column_null :receipts, :receipt_path, false, ""
    add_index :receipts, :status, name: "ix_receipt_status"

    # =========================================================
    # 2.9 redeem_transactions — Add currency + ratio + indexes
    # =========================================================
    add_column :redeem_transactions, :discount_currency,                :string,  limit: 3, default: "JOD", null: false
    add_column :redeem_transactions, :applied_points_to_currency_ratio, :decimal, precision: 12, scale: 6

    add_index :redeem_transactions, :status,            name: "ix_redeem_transaction_status"
    add_index :redeem_transactions, :verification_code, unique: true, name: "ix_redeem_transaction_verification_code"

    # =========================================================
    # 2.10 shops — Make bio, cover_image_url, logo_url NOT NULL
    # =========================================================
    change_column_null :shops, :bio,             false, ""
    change_column_null :shops, :cover_image_url, false, ""
    change_column_null :shops, :logo_url,        false, ""

    # =========================================================
    # 2.11 stamps — Rename active→is_active, make columns NOT NULL
    # =========================================================
    rename_column :stamps, :active, :is_active
    change_column_null :stamps, :description,   false, ""
    change_column_null :stamps, :image_url,     false, ""
    change_column_null :stamps, :stamp_icon_url,false, ""

    add_index :stamps, :is_active, name: "ix_stamp_is_active"

    # =========================================================
    # 2.12 stamp_transactions — Rename columns, change redemption_ref to uuid
    # =========================================================
    # Remove old FK and index for receipt_id / stamp_id before renaming
    remove_foreign_key :stamp_transactions, :receipts, if_exists: true
    remove_foreign_key :stamp_transactions, :stamps,   if_exists: true
    remove_index :stamp_transactions, name: "index_stamp_transactions_on_receipt_id", if_exists: true
    remove_index :stamp_transactions, name: "index_stamp_transactions_on_stamp_id",   if_exists: true

    rename_column :stamp_transactions, :stamp_id,        :stamp_program_id
    rename_column :stamp_transactions, :transaction_type, :type
    rename_column :stamp_transactions, :receipt_id,       :redemption_ref

    # Change redemption_ref from uuid (FK to receipts) to uuid (FK to qrs)
    add_index :stamp_transactions, :stamp_program_id, name: "index_stamp_transactions_on_stamp_program_id"
    add_index :stamp_transactions, :redemption_ref,   name: "ix_stamp_transaction_redemption_ref"

    add_foreign_key :stamp_transactions, :stamps, column: :stamp_program_id, on_delete: :restrict
    add_foreign_key :stamp_transactions, :qrs,    column: :redemption_ref,   on_delete: :restrict

    # =========================================================
    # 2.13 system_configs — Add mall_id, make updated_by_admin_id NOT NULL
    # =========================================================
    add_reference :system_configs, :mall, type: :uuid, null: false,
                  foreign_key: { on_delete: :restrict },
                  index: { unique: true },
                  default: nil

    change_column_null :system_configs, :updated_by_admin_id, false, "00000000-0000-0000-0000-000000000000"
    add_foreign_key :system_configs, :mall_admins, column: :updated_by_admin_id, on_delete: :restrict

    # =========================================================
    # 2.14 tiers — Rename tier_name→name, add tier_order
    # =========================================================
    remove_index :tiers, name: "index_tiers_on_tier_name", if_exists: true
    rename_column :tiers, :tier_name, :name
    add_column :tiers, :tier_order, :integer
    change_column_null :tiers, :icon_url, false, ""
    add_index :tiers, :name,       unique: true, name: "index_tiers_on_name"
    add_index :tiers, :tier_order, unique: true, name: "ix_tier_tier_order"

    # =========================================================
    # 2.15 user_points_balances — Change PK to user_points_balance_id
    # =========================================================
    # The current PK IS user_id. We need to add a new uuid PK and keep user_id as unique FK.
    remove_foreign_key :user_points_balances, :users, if_exists: true
    remove_index :user_points_balances, name: "index_user_points_balances_on_user_id", if_exists: true

    # Drop the user_id PK constraint and add a proper id column
    execute "ALTER TABLE user_points_balances DROP CONSTRAINT user_points_balances_pkey"
    execute "ALTER TABLE user_points_balances ADD COLUMN user_points_balance_id uuid DEFAULT gen_random_uuid() NOT NULL"
    execute "ALTER TABLE user_points_balances ADD PRIMARY KEY (user_points_balance_id)"

    # Re-add user_id as a unique FK
    add_index :user_points_balances, :user_id, unique: true, name: "ix_user_points_balance_user_id"
    add_foreign_key :user_points_balances, :users, on_delete: :cascade

    # =========================================================
    # 2.17 users — Rename firstname→first_name, lastname→last_name
    # =========================================================
    rename_column :users, :firstname, :first_name
    rename_column :users, :lastname,  :last_name

    # =========================================================
    # Section 1 — Create new tables
    # =========================================================

    # 1.1 mall_admin_password_reset_requests
    create_table :mall_admin_password_reset_requests, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :mall_admin, type: :uuid, null: false,
                   foreign_key: { to_table: :mall_admins, on_delete: :cascade }
      t.string   :token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
      t.timestamps
    end
    add_index :mall_admin_password_reset_requests, :mall_admin_id, unique: true,
              name: "ix_mall_admin_password_reset_request_mall_admin_id"
    add_index :mall_admin_password_reset_requests, :token_hash,    unique: true,
              name: "ix_mall_admin_password_reset_request_token_hash"

    # 1.2 mall_admin_sessions
    create_table :mall_admin_sessions, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :mall_admin, type: :uuid, null: false,
                   foreign_key: { to_table: :mall_admins, on_delete: :cascade }
      t.string   :refresh_token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
      t.datetime :created_at,     null: false
    end
    add_index :mall_admin_sessions, :mall_admin_id,       name: "ix_mall_admin_session_mall_admin_id"
    add_index :mall_admin_sessions, :refresh_token_hash,  unique: true,
              name: "ix_mall_admin_session_refresh_token_hash"

    # 1.3 shop_admin_password_reset_requests
    create_table :shop_admin_password_reset_requests, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :shop_admin, type: :uuid, null: false,
                   foreign_key: { to_table: :shop_admins, on_delete: :cascade }
      t.string   :token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
      t.timestamps
    end
    add_index :shop_admin_password_reset_requests, :shop_admin_id, unique: true,
              name: "ix_shop_admin_password_reset_request_shop_admin_id"
    add_index :shop_admin_password_reset_requests, :token_hash,    unique: true,
              name: "ix_shop_admin_password_reset_request_token_hash"

    # 1.4 shop_admin_sessions
    create_table :shop_admin_sessions, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :shop_admin, type: :uuid, null: false,
                   foreign_key: { to_table: :shop_admins, on_delete: :cascade }
      t.string   :refresh_token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
      t.datetime :created_at,     null: false
    end
    add_index :shop_admin_sessions, :shop_admin_id,      name: "ix_shop_admin_session_shop_admin_id"
    add_index :shop_admin_sessions, :refresh_token_hash, unique: true,
              name: "ix_shop_admin_session_refresh_token_hash"

    # 1.5 shop_points_wallets
    create_table :shop_points_wallets, id: false do |t|
      t.references :shop, type: :uuid, null: false,
                   foreign_key: { on_delete: :cascade },
                   index: { unique: true }
      t.integer  :points_received, default: 0
      t.datetime :last_updated, null: false, default: -> { "now()" }
    end

    # 1.6 stamp_redemptions
    create_table :stamp_redemptions, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :stamp, type: :uuid, null: false,
                   foreign_key: { on_delete: :restrict }
      t.references :user,  type: :uuid, null: false,
                   foreign_key: { on_delete: :restrict }
      t.references :shop,  type: :uuid, null: false,
                   foreign_key: { on_delete: :restrict }
      t.references :qr, type: :uuid, null: false,
                   foreign_key: { to_table: :qrs, on_delete: :restrict },
                   index: { unique: true }
      t.datetime :created_at, null: false
    end
    add_index :stamp_redemptions, :stamp_id, name: "ix_stamp_redemption_stamp_id"
    add_index :stamp_redemptions, :user_id,  name: "ix_stamp_redemption_user_id"
    add_index :stamp_redemptions, :shop_id,  name: "ix_stamp_redemption_shop_id"
    add_index :stamp_redemptions, [:user_id, :stamp_id], name: "ix_stamp_redemption_user_id_stamp_id"

    # 1.7 user_sessions
    create_table :user_sessions, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, type: :uuid, null: false,
                   foreign_key: { on_delete: :cascade }
      t.string   :refresh_token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
      t.datetime :created_at,     null: false
    end
    add_index :user_sessions, :user_id,            name: "ix_user_session_user_id"
    add_index :user_sessions, :refresh_token_hash, unique: true,
              name: "ix_user_session_refresh_token_hash"

    # 1.8 password_reset_requests
    create_table :password_reset_requests, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, type: :uuid, null: false,
                   foreign_key: { on_delete: :cascade },
                   index: { unique: true }
      t.string   :token_hash, null: false, limit: 128
      t.datetime :expires_at_utc, null: false
    end
    add_index :password_reset_requests, :token_hash, unique: true,
              name: "ix_password_reset_request_token_hash"
  end
end
