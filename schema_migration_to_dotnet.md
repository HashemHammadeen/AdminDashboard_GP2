# Rails to .NET Schema Migration Plan

This file lists all changes needed to update the Rails app schema to match the .NET (LoopContext) schema.

## 1. Create Missing Tables

### 1.1 Create `mall_admin_password_reset_requests` table
```ruby
# migration
create_table :mall_admin_password_reset_requests, id: :uuid do |t|
  t.references :mall_admin, type: :uuid, null: false, foreign_key: { to_table: :mall_admins, on_delete: :cascade }
  t.string :token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
  t.timestamps
end
add_index :mall_admin_password_reset_requests, :mall_admin_id, unique: true, name: 'ix_mall_admin_password_reset_request_mall_admin_id'
add_index :mall_admin_password_reset_requests, :token_hash, unique: true, name: 'ix_mall_admin_password_reset_request_token_hash'
```

### 1.2 Create `mall_admin_sessions` table
```ruby
create_table :mall_admin_sessions, id: :uuid do |t|
  t.references :mall_admin, type: :uuid, null: false, foreign_key: { to_table: :mall_admins, on_delete: :cascade }
  t.string :refresh_token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
  t.datetime :created_at, null: false
end
add_index :mall_admin_sessions, :mall_admin_id, name: 'ix_mall_admin_session_mall_admin_id'
add_index :mall_admin_sessions, :refresh_token_hash, unique: true, name: 'ix_mall_admin_session_refresh_token_hash'
```

### 1.3 Create `shop_admin_password_reset_requests` table
```ruby
create_table :shop_admin_password_reset_requests, id: :uuid do |t|
  t.references :shop_admin, type: :uuid, null: false, foreign_key: { to_table: :shop_admins, on_delete: :cascade }
  t.string :token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
  t.timestamps
end
add_index :shop_admin_password_reset_requests, :shop_admin_id, unique: true, name: 'ix_shop_admin_password_reset_request_shop_admin_id'
add_index :shop_admin_password_reset_requests, :token_hash, unique: true, name: 'ix_shop_admin_password_reset_request_token_hash'
```

### 1.4 Create `shop_admin_sessions` table
```ruby
create_table :shop_admin_sessions, id: :uuid do |t|
  t.references :shop_admin, type: :uuid, null: false, foreign_key: { to_table: :shop_admins, on_delete: :cascade }
  t.string :refresh_token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
  t.datetime :created_at, null: false
end
add_index :shop_admin_sessions, :shop_admin_id, name: 'ix_shop_admin_session_shop_admin_id'
add_index :shop_admin_sessions, :refresh_token_hash, unique: true, name: 'ix_shop_admin_session_refresh_token_hash'
```

### 1.5 Create `shop_points_wallets` table
```ruby
create_table :shop_points_wallets, id: false do |t|
  t.references :shop, type: :uuid, null: false, foreign_key: { on_delete: :cascade }, index: { unique: true }
  t.integer :points_received, default: 0
  t.datetime :last_updated, null: false, default: -> { 'now()' }
end
```

### 1.6 Create `stamp_redemptions` table
```ruby
create_table :stamp_redemptions, id: :uuid do |t|
  t.references :stamp, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
  t.references :user, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
  t.references :shop, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
  t.references :qr, type: :uuid, null: false, foreign_key: { to_table: :qrs, on_delete: :restrict }, index: { unique: true }
  t.datetime :created_at, null: false
end
add_index :stamp_redemptions, :stamp_id, name: 'ix_stamp_redemption_stamp_id'
add_index :stamp_redemptions, :user_id, name: 'ix_stamp_redemption_user_id'
add_index :stamp_redemptions, :shop_id, name: 'ix_stamp_redemption_shop_id'
add_index :stamp_redemptions, [:user_id, :stamp_id], name: 'ix_stamp_redemption_user_id_stamp_id'
```

### 1.7 Create `user_sessions` table
```ruby
create_table :user_sessions, id: :uuid do |t|
  t.references :user, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
  t.string :refresh_token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
  t.datetime :created_at, null: false
end
add_index :user_sessions, :user_id, name: 'ix_user_session_user_id'
add_index :user_sessions, :refresh_token_hash, unique: true, name: 'ix_user_session_refresh_token_hash'
```

### 1.8 Create `password_reset_requests` table
```ruby
create_table :password_reset_requests, id: :uuid do |t|
  t.references :user, type: :uuid, null: false, foreign_key: { on_delete: :cascade }, index: { unique: true }
  t.string :token_hash, null: false, limit: 128
  t.datetime :expires_at_utc, null: false
end
add_index :password_reset_requests, :token_hash, unique: true, name: 'ix_password_reset_request_token_hash'
```

---

## 2. Modify Existing Tables

### 2.1 `mall_admins` - Replace Devise with password_hash
```ruby
# Remove Devise columns
remove_column :mall_admins, :encrypted_password, :string
remove_column :mall_admins, :reset_password_token, :string
remove_column :mall_admins, :reset_password_sent_at, :datetime
remove_column :mall_admins, :remember_created_at, :datetime

# Add password_hash
add_column :mall_admins, :password_hash, :text, null: false
```

### 2.2 `shop_admins` - Replace Devise with password_hash
```ruby
# Remove Devise columns
remove_column :shop_admins, :encrypted_password, :string
remove_column :shop_admins, :reset_password_token, :string
remove_column :shop_admins, :reset_password_sent_at, :datetime
remove_column :shop_admins, :remember_created_at, :datetime

# Add password_hash
add_column :shop_admins, :password_hash, :text, null: false
```

### 2.3 `audit_logs` - Replace admin_id+admin_type with separate columns
```ruby
# Remove old columns
remove_column :audit_logs, :admin_id, :uuid
remove_column :audit_logs, :admin_type, :string

# Add new columns
add_column :audit_logs, :mall_admin_id, :uuid
add_column :audit_logs, :shop_admin_id, :uuid

# Add foreign keys with SET NULL behavior
add_foreign_key :audit_logs, :mall_admins, column: :mall_admin_id, on_delete: :nullify
add_foreign_key :audit_logs, :shop_admins, column: :shop_admin_id, on_delete: :nullify

# Add indexes
add_index :audit_logs, :mall_admin_id, name: 'ix_audit_log_mall_admin_id'
add_index :audit_logs, :shop_admin_id, name: 'ix_audit_log_shop_admin_id'
add_index :audit_logs, :created_at, name: 'ix_audit_log_created_at'
```

### 2.4 `categories` - Rename and add mall_id
```ruby
# Rename category_name to name
rename_column :categories, :category_name, :name

# Add mall_id
add_reference :categories, :mall, type: :uuid, null: false, foreign_key: { on_delete: :cascade }

# Change column null constraints
change_column_null :categories, :description, false
change_column_null :categories, :icon_url, false

# Add index on mall_id
add_index :categories, :mall_id, name: 'ix_category_mall_id'
```

### 2.5 `earn_transactions` - Add currency and index
```ruby
# Add purchase_currency column
add_column :earn_transactions, :purchase_currency, :string, limit: 3, default: 'JOD', null: false

# Add index on created_at
add_index :earn_transactions, :created_at, name: 'ix_earn_transaction_created_at'
```

### 2.6 `offers` - Rename and remove columns
```ruby
# Rename active to is_active
rename_column :offers, :active, :is_active

# Remove unnecessary columns
remove_column :offers, :inactive_by_mall_admin, :boolean
remove_column :offers, :reactivation_requested, :boolean

# Make columns NOT NULL
change_column_null :offers, :description, false
change_column_null :offers, :image_url, false
change_column_null :offers, :name, false
change_column_null :offers, :reward_type, false
change_column_null :offers, :reward_value, false

# Add indexes
add_index :offers, :is_active, name: 'ix_offer_is_active'
add_index :offers, :start_date, name: 'ix_offer_start_date'
```

### 2.7 `qrs` / `qr_codes` - Change qr_code_data to jsonb
```ruby
# Change column type from text to jsonb
change_column :qrs, :qr_code_data, :jsonb

# Add index on expires_at
add_index :qrs, :expires_at, name: 'ix_qr_code_expires_at'
```

### 2.8 `receipts` - Add currency and make NOT NULL
```ruby
# Add receipt_currency column (for the owned Amount entity in .NET)
add_column :receipts, :receipt_currency, :string, limit: 3, default: 'JOD', null: false

# Make receipt_path NOT NULL
change_column_null :receipts, :receipt_path, false

# Add index on status
add_index :receipts, :status, name: 'ix_receipt_status'
```

### 2.9 `redeem_transactions` - Add currency and ratio
```ruby
# Add discount_currency column
add_column :redeem_transactions, :discount_currency, :string, limit: 3, default: 'JOD', null: false

# Add applied_points_to_currency_ratio
add_column :redeem_transactions, :applied_points_to_currency_ratio, :decimal, precision: 12, scale: 6

# Add indexes
add_index :redeem_transactions, :status, name: 'ix_redeem_transaction_status'
add_index :redeem_transactions, :verification_code, unique: true, name: 'ix_redeem_transaction_verification_code'
```

### 2.10 `shops` - Make columns NOT NULL
```ruby
# Make columns NOT NULL
change_column_null :shops, :bio, false
change_column_null :shops, :cover_image_url, false
change_column_null :shops, :logo_url, false
```

### 2.11 `stamps` - Rename and modify
```ruby
# Rename active to is_active
rename_column :stamps, :active, :is_active

# Make columns NOT NULL
change_column_null :stamps, :description, false
change_column_null :stamps, :image_url, false
change_column_null :stamps, :name, false
change_column_null :stamps, :reward_type, false
change_column_null :stamps, :stamp_icon_url, false

# Add index on is_active
add_index :stamps, :is_active, name: 'ix_stamp_is_active'
```

### 2.12 `stamp_transactions` - Rename columns
```ruby
# Rename columns to match .NET
rename_column :stamp_transactions, :stamp_id, :stamp_program_id
rename_column :stamp_transactions, :transaction_type, :type
rename_column :stamp_transactions, :receipt_id, :redemption_ref

# Change column types
change_column :stamp_transactions, :redemption_ref, :uuid

# Add index on redemption_ref
add_index :stamp_transactions, :redemption_ref, name: 'ix_stamp_transaction_redemption_ref'

# Add foreign key for redemption_ref to qrs table
add_foreign_key :stamp_transactions, :qrs, column: :redemption_ref, on_delete: :restrict
```

### 2.13 `system_configs` - Add mall_id and fix columns
```ruby
# Add mall_id column
add_reference :system_configs, :mall, type: :uuid, null: false, foreign_key: { on_delete: :restrict }, index: { unique: true }

# Make updated_by_admin_id NOT NULL and add FK to mall_admins
change_column_null :system_configs, :updated_by_admin_id, false
add_foreign_key :system_configs, :mall_admins, column: :updated_by_admin_id, on_delete: :restrict

# Remove id if using different PK (optional - .NET uses config_id)
# Keep id as is for Rails convention, or change to config_id
```

### 2.14 `tiers` - Rename and add tier_order
```ruby
# Rename tier_name to name
rename_column :tiers, :tier_name, :name

# Add tier_order column
add_column :tiers, :tier_order, :integer

# Make icon_url NOT NULL
change_column_null :tiers, :icon_url, false

# Add unique index on tier_order
add_index :tiers, :tier_order, unique: true, name: 'ix_tier_tier_order'
```

### 2.15 `user_points_balances` - Change primary key
```ruby
# Remove old primary key
remove_column :user_points_balances, :user_id, :uuid

# Add new primary key
add_column :user_points_balances, :user_points_balance_id, :uuid, primary_key: true, default: -> { 'gen_random_uuid()' }

# Add user_id as unique foreign key
add_column :user_points_balances, :user_id, :uuid, null: false
add_foreign_key :user_points_balances, :users, on_delete: :cascade
add_index :user_points_balances, :user_id, unique: true, name: 'ix_user_points_balance_user_id'

# Rename updated_at to last_updated (optional - .NET uses last_updated)
# Keep Rails convention or change to match .NET
```

### 2.16 `user_stamp_cards` - Verify structure
```ruby
# Already has composite primary key in Rails, verify it matches .NET
# .NET has PK on (user_id, stamp_id) - should already match

# Ensure columns match
# Note: Rails table name is user_stamp_cards, .NET is user_stamp_card
```

### 2.17 `users` - Rename columns
```ruby
# Rename columns
rename_column :users, :firstname, :first_name
rename_column :users, :lastname, :last_name

# Ensure proper indexes (should already exist from schema)
# Verify unique index on email and phone
```

---

## 3. Update Foreign Keys to Match .NET Delete Behaviors

```ruby
# audit_logs - already handled in section 2.3 (SET NULL)

# categories - mall_id cascade delete (already in section 2.4)

# earn_transactions - shops and users restrict delete
# Already should be correct, verify:
# add_foreign_key :earn_transactions, :shops, on_delete: :restrict
# add_foreign_key :earn_transactions, :users, on_delete: :restrict

# offer_redemptions - change receipt_id FK if needed
# .NET doesn't have receipt_id in offer_redemption, has different design

# receipts - shops and users restrict delete
# Verify foreign keys have on_delete: :restrict

# redeem_transactions - shops and users restrict delete
# Verify foreign keys have on_delete: :restrict

# shop_admins - shops restrict delete
# Verify foreign key has on_delete: :restrict

# shops - categories and malls restrict delete
# Verify foreign keys have on_delete: :restrict

# stamp_transactions - stamp_program_id references stamps, restrict delete
# Verify foreign key has on_delete: :restrict

# stamps - shops restrict delete
# Verify foreign key has on_delete: :restrict

# users - tiers restrict delete
# Verify foreign key has on_delete: :restrict
```

---

## 4. Table Naming Convention (Optional)

If you want to match .NET's singular table naming convention:

```ruby
# Rename tables to singular (optional - Rails convention is plural)
# Only do this if you want to match .NET exactly

rename_table :audit_logs, :audit_log
rename_table :earn_transactions, :earn_transaction
rename_table :mall_admins, :mall_admin
rename_table :malls, :mall
rename_table :offer_redemptions, :offer_redemption
rename_table :offers, :offer
rename_table :qrs, :qr_code
rename_table :receipts, :receipt
rename_table :redeem_transactions, :redeem_transaction
rename_table :shop_admins, :shop_admin
rename_table :shops, :shop
rename_table :stamp_transactions, :stamp_transaction
rename_table :stamps, :stamp
rename_table :tiers, :tier
rename_table :user_points_balances, :user_points_balance
rename_table :user_stamp_cards, :user_stamp_card
rename_table :users, :user
```

**Note**: Only rename tables if you're also updating all model associations and code references.

---

## 5. Summary Checklist

- [ ] Create 8 missing tables (sections 1.1 - 1.8)
- [ ] Replace Devise in mall_admins and shop_admins (2.1, 2.2)
- [ ] Fix audit_logs structure (2.3)
- [ ] Fix categories with mall_id (2.4)
- [ ] Add currency to earn_transactions (2.5)
- [ ] Fix offers table (2.6)
- [ ] Fix qrs to use jsonb (2.7)
- [ ] Fix receipts with currency (2.8)
- [ ] Fix redeem_transactions (2.9)
- [ ] Make shop columns NOT NULL (2.10)
- [ ] Fix stamps table (2.11)
- [ ] Rename stamp_transactions columns (2.12)
- [ ] Fix system_configs with mall_id (2.13)
- [ ] Fix tiers with tier_order (2.14)
- [ ] Fix user_points_balances PK (2.15)
- [ ] Rename user columns (2.17)
- [ ] Verify foreign key behaviors (section 3)
- [ ] Optional: Rename tables to singular (section 4)
