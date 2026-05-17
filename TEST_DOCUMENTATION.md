# Test Documentation - Admin Dashboard

## Project Overview

- **Framework**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL with UUID primary keys
- **Testing**: Minitest (Rails default)
- **Authentication**: Custom session-based auth with `has_secure_password`
- **Authorization**: CanCanCan for role-based access control

## Directory Structure

```
test/
├── test_helper.rb           # Base test configuration
├── fixtures/               # YAML fixtures for test data
├── models/                 # Model unit tests
│   ├── mall_test.rb
│   ├── user_test.rb
│   ├── shop_test.rb
│   ├── tier_test.rb
│   ├── category_test.rb
│   ├── shop_admin_test.rb
│   ├── mall_admin_test.rb
│   ├── earn_transaction_test.rb
│   ├── redeem_transaction_test.rb
│   ├── receipt_test.rb
│   ├── offer_test.rb
│   ├── offer_redemption_test.rb
│   ├── stamp_test.rb
│   ├── stamp_transaction_test.rb
│   ├── user_stamp_card_test.rb
│   ├── user_points_balance_test.rb
│   ├── system_config_test.rb
│   └── qr_test.rb
├── controllers/            # Controller integration tests
│   ├── malls_controller_test.rb
│   ├── users_controller_test.rb
│   ├── shops_controller_test.rb
│   ├── categories_controller_test.rb
│   ├── tiers_controller_test.rb
│   ├── mall_admins_controller_test.rb
│   ├── shop_admins_controller_test.rb
│   ├── earn_transactions_controller_test.rb
│   ├── redeem_transactions_controller_test.rb
│   ├── receipts_controller_test.rb
│   ├── offers_controller_test.rb
│   ├── stamps_controller_test.rb
│   ├── qrs_controller_test.rb
│   ├── user_stamp_cards_controller_test.rb
│   ├── stamp_transactions_controller_test.rb
│   ├── offer_redemptions_controller_test.rb
│   ├── system_configs_controller_test.rb
│   ├── user_points_balances_controller_test.rb
│   ├── audit_logs_controller_test.rb
│   ├── mall_dashboards_controller_test.rb
│   ├── shop_dashboards_controller_test.rb
│   └── home_controller_test.rb
└── integration/            # Integration tests (empty)
```

## Database Schema

### All Tables with Primary Keys and Columns

| Table | Primary Key | Key Columns |
|-------|-------------|-------------|
| `mall` | `mall_id` (UUID) | name, location, logo_url, cover_image_url, created_at |
| `mall_admin` | `mall_admin_id` (UUID) | mall_id, name, email, phone, password_hash, created_at, is_active (default true) |
| `mall_admin_session` | `session_id` (UUID) | mall_admin_id, refresh_token_hash, created_at, expires_at_utc |
| `mall_admin_password_reset_request` | `request_id` (UUID) | mall_admin_id, token_hash, expires_at_utc |
| `category` | `category_id` (UUID) | mall_id, name, description, icon_url, display_order, created_at |
| `shop` | `shop_id` (UUID) | mall_id, category_id, name (unique), bio, logo_url, cover_image_url, website_url, social_links (jsonb), is_active, created_at |
| `shop_admin` | `shop_admin_id` (UUID) | shop_id, name, email, phone, password_hash, is_active, created_at |
| `shop_admin_session` | `session_id` (UUID) | shop_admin_id, refresh_token_hash, created_at, expires_at_utc |
| `shop_admin_password_reset_request` | `request_id` (UUID) | shop_admin_id, token_hash, expires_at_utc |
| `shop_points_wallet` | `shop_id` (UUID, no auto-increment) | points_received, last_updated |
| `tier` | `tier_id` (UUID) | name (unique), points_required, tier_order (unique), color_hex, icon_url, benefits (jsonb), created_at |
| `user` | `user_id` (UUID) | tier_id, first_name, last_name, email (unique), phone (unique), password_hash, gender, profile_image_url, created_at |
| `user_points_balance` | `user_points_balance_id` (UUID) | user_id, total_points, lifetime_points (custom updated_at returns Time.current) |
| `user_session` | `session_id` (UUID) | user_id, refresh_token_hash, created_at, expires_at_utc |
| `password_reset_request` | `request_id` (UUID) | user_id, token_hash, expires_at_utc |
| `earn_transaction` | `earn_id` (UUID) | user_id, shop_id, PurchaseAmount (decimal 10,2), PurchaseCurrency (default "JOD"), points_earned, transaction_ref, created_at |
| `redeem_transaction` | `redeem_id` (UUID) | user_id, shop_id, points_used, DiscountAmount (decimal 10,2), DiscountCurrency (default "JOD"), verification_code (unique 6 chars), status (enum: pending/verified/cancelled, default pending), completed_at, created_at, applied_points_to_currency_ratio |
| `receipt` | `receipt_id` (UUID) | user_id, shop_id, Amount (decimal 12,2), Currency (default "JOD"), receipt_path, receipt_details (jsonb), status (enum: pending/approved/rejected), created_at |
| `offer` | `offer_id` (UUID) | shop_id, name, description, image_url, reward_type, reward_value (jsonb), is_active, start_date, end_date, created_at |
| `offer_redemption` | `redemption_id` (UUID) | user_id, offer_id, shop_id, redemption_ref (UUID), created_at |
| `stamp` | `stamp_id` (UUID) | shop_id, name, description, image_url, stamp_icon_url, stamps_required, reward_type, is_active, start_date, end_date, created_at |
| `user_stamp_card` | composite [:user_id, :stamp_id] | stamps_counter (default 0), is_completed (default false), last_transaction, created_at (updated_at returns created_at) |
| `stamp_transaction` | `stamp_tx_id` (UUID) | user_id, shop_id, stamp_program_id (FK to Stamp), type, stamps_count (default 1), redemption_ref (UUID), created_at (STI disabled) |
| `stamp_redemption` | `redemption_id` (UUID) | user_id, shop_id, stamp_id, redemption_ref (UUID), created_at |
| `qr_code` | `qr_id` (UUID) | user_id (optional), shop_id (optional), qr_code_data (jsonb), expires_at, created_at/updated_at return Time.current |
| `system_config` | `config_id` (UUID) | mall_id (unique), earn_points_per_currency (default 1.0), points_to_currency_ratio (default 0.01), min_redemption_threshold (default 100), updated_by_admin_id, updated_at |
| `audit_log` | `log_id` (UUID) | action_type, mall_admin_id, shop_admin_id, user_id, shop_id, points, metadata (jsonb), created_at |

## Key Model Details

### Authentication Models (use has_secure_password)

```ruby
# MallAdmin
class MallAdmin < ApplicationRecord
  self.primary_key = "mall_admin_id"
  alias_attribute :password_digest, :password_hash  # bcrypt uses this
  has_secure_password  # Requires password_digest
  belongs_to :mall
end

# ShopAdmin
class ShopAdmin < ApplicationRecord
  self.primary_key = "shop_admin_id"
  alias_attribute :password_digest, :password_hash
  has_secure_password
  belongs_to :shop
end

# User
class User < ApplicationRecord
  self.primary_key = "user_id"
  alias_attribute :password_digest, :password_hash
  has_secure_password
  belongs_to :tier
end
```

### Special Models

#### Shop (Unique name constraint)
```ruby
class Shop < ApplicationRecord
  self.primary_key = "shop_id"
  validates :name, presence: true, uniqueness: true
  store_accessor :social_links, :facebook, :instagram, :x
  attr_accessor :logo_file, :cover_image_file  # Virtual for uploads
end
```

#### UserStampCard (Composite Primary Key)
```ruby
# Primary key is [:user_id, :stamp_id] - not a standard auto-increment ID
# Must be created with both IDs present
```

#### SystemConfig
```ruby
# One config per mall
# record_timestamps = false, updated_at is managed manually
```

#### Qr (qr_code table)
```ruby
# record_timestamps = false
# created_at and updated_at return Time.current
# user_id and shop_id are optional (belongs_to optional: true)
```

## Controller Authentication

### Session Setup Pattern (Minitest)
```ruby
# For mall admin authentication
post mall_admins_login_url, params: { email: "admin@example.com", password: "password123" }

# For shop admin authentication
post shop_admins_login_url, params: { email: "shop@example.com", password: "password123" }

# Session is stored in Rails session, persist across requests
```

### Authentication Methods
```ruby
# ApplicationController provides:
current_mall_admin      # Returns MallAdmin or nil
current_shop_admin      # Returns ShopAdmin or nil
current_admin           # Returns either
mall_admin_signed_in?   # Boolean
shop_admin_signed_in?   # Boolean

# Auth filters:
authenticate_mall_admin!   # Redirects to /mall_admins/login if not signed in
authenticate_shop_admin!   # Redirects to /shop_admins/login if not signed in
authenticate_any_admin!     # Requires either type

# CanCanCan integration:
# Uses current_admin for Ability initialization
# Redirects to root_path on access denied
```

## Authorization (CanCanCan Ability)

### MallAdmin Abilities
- Can manage: Mall (own), Shop (in mall), Category, Tier, SystemConfig
- Can manage: MallAdmin (in mall), ShopAdmin (shops in mall)
- Can manage: User, UserPointsBalance
- Can read: AuditLog
- Can read: EarnTransaction, RedeemTransaction, Receipt (shops in mall)
- Can manage: Offer (shops in mall)
- Can read: Stamp, OfferRedemption, StampTransaction, UserStampCard, Qr

### ShopAdmin Abilities
- Can read/update: Shop (own)
- Can manage: Offer, Stamp, Receipt, EarnTransaction, RedeemTransaction, Qr (own shop)
- Can read: OfferRedemption, StampTransaction
- Can read/create/update: UserStampCard
- Can read/update: ShopAdmin (own)

## Routes

### Mall Admin Routes
```
GET    /mall_admins/login        -> mall_admins/sessions#new
POST   /mall_admins/login        -> mall_admins/sessions#create
DELETE /mall_admins/logout       -> mall_admins/sessions#destroy
GET    /mall_admin_root          -> mall_dashboards#index

resources :malls
resources :shops (member: approve, deactivate)
resources :users
resources :categories
resources :tiers
resources :system_configs, only: [:index, :show, :edit, :update]
resources :mall_admins
resources :user_points_balances, only: [:index, :show, :edit, :update]
resources :audit_logs, only: [:index, :show]
```

### Shop Admin Routes
```
GET    /shop_admins/login        -> shop_admins/sessions#new
POST   /shop_admins/login        -> shop_admins/sessions#create
DELETE /shop_admins/logout       -> shop_admins/sessions#destroy
GET    /shop_admin_root          -> shop_dashboards#index

resources :earn_transactions
resources :redeem_transactions
resources :receipts
resources :offers
resources :stamps
resources :stamp_transactions, only: [:index, :show]
resources :offer_redemptions, only: [:index, :show]
resources :user_stamp_cards, only: [:index, :show, :new, :create]
resources :qrs
resources :shop_admins, only: [:index, :show, :edit, :update, :new, :create] (member: toggle_active)
```

### Root Routes
```
root to: "home#index"
get "data_analysis" => "data_analysis#index"
get "up" => "rails/health#show"
```

## Fixtures Setup

### Fixture Format (YAML)
```yaml
# Use association names for foreign keys, not column names
one:
  name: Test Mall
  location: Test Location
  # has_one/belongs_to: use association name
  # has_many: not specified in fixture (created via association)
```

### Existing Fixtures
- `malls.yml` - 2 entries (one, two)
- `categories.yml` - 2 entries
- `shops.yml` - 2 entries
- `tiers.yml` - 2 entries
- `users.yml` - 2 entries
- `shop_admins.yml` - 2 entries
- `mall_admins.yml` - 2 entries
- `offers.yml` - 2 entries
- `stamps.yml` - 2 entries
- `earn_transactions.yml` - 2 entries
- `redeem_transactions.yml` - 2 entries
- `receipts.yml` - 2 entries
- `qrs.yml` - 2 entries
- `user_stamp_cards.yml` - 2 entries
- `stamp_transactions.yml` - 2 entries
- `user_points_balances.yml` - 2 entries
- `system_configs.yml` - 2 entries
- `offer_redemptions.yml` - 2 entries

### Important: Fixtures are COMMENTED OUT
```ruby
# In test_helper.rb:
# fixtures :all  # <- COMMENTED OUT

# This means fixtures are NOT automatically loaded
# Tests need to create their own test data or load fixtures manually
```

## Test Helper Configuration

```ruby
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    # fixtures :all  # COMMENTED OUT - must create test data manually
  end
end
```

## Password Hashing

For testing with password authentication:
```ruby
BCrypt::Password.create("password123")  # Creates valid password_hash
```

## UUID Handling

All primary keys are UUIDs. When creating tests, use:
```ruby
SecureRandom.uuid  # Or let the database generate via gen_random_uuid()
```

## Writing Tests - Patterns

### Model Test Pattern
```ruby
require "test_helper"

class ShopTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(
      name: "Test Mall",
      location: "Test Location"
    )
    @category = Category.create!(
      mall: @mall,
      name: "Test Category",
      description: "Description",
      icon_url: "https://example.com/icon.png"
    )
  end

  test "valid shop creation" do
    shop = Shop.new(
      mall: @mall,
      category: @category,
      name: "Unique Shop Name",
      bio: "Test bio",
      logo_url: "https://example.com/logo.png",
      cover_image_url: "https://example.com/cover.png"
    )
    assert shop.save
  end

  test "name uniqueness" do
    Shop.create!(
      mall: @mall,
      category: @category,
      name: "Unique Name",
      bio: "Bio",
      logo_url: "logo.png",
      cover_image_url: "cover.png"
    )
    shop2 = Shop.new(
      mall: @mall,
      category: @category,
      name: "Unique Name",
      bio: "Bio",
      logo_url: "logo.png",
      cover_image_url: "cover.png"
    )
    refute shop2.save
    assert shop2.errors[:name].any?
  end
end
```

### Controller Test Pattern (with authentication)
```ruby
require "test_helper"

class ShopsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @mall = Mall.create!(name: "Test Mall", location: "Location")
    @category = Category.create!(
      mall: @mall,
      name: "Category",
      description: "Desc",
      icon_url: "http://example.com/icon.png"
    )
    @mall_admin = MallAdmin.create!(
      mall: @mall,
      name: "Admin",
      email: "admin#{SecureRandom.uuid}@test.com",
      phone: "123456789#{SecureRandom.uuid[0]}",
      password: "password123"
    )
  end

  test "mall admin can access shops" do
    # Authenticate
    post mall_admins_login_url, params: {
      email: @mall_admin.email,
      password: "password123"
    }
    assert_redirected_to mall_admin_root_path

    # Now can access shops
    get shops_url
    assert_response :success
  end

  test "unauthenticated cannot access" do
    get shops_url
    # Will redirect to login
    assert_redirected_to mall_admins_login_path
  end
end
```

### Session Authentication
```ruby
# To authenticate a mall admin in tests:
post mall_admins_login_url, params: {
  email: mall_admin.email,
  password: "password123"
}

# To authenticate a shop admin in tests:
post shop_admins_login_url, params: {
  email: shop_admin.email,
  password: "password123"
}
```

## Required Test Data Setup

For tests to pass, always create required associated records:

### Mall Admin Tests Need:
- Mall
- MallAdmin (with bcrypt password)

### Shop Admin Tests Need:
- Mall
- Category
- Shop
- ShopAdmin (with bcrypt password)

### User Tests Need:
- Tier
- User (with bcrypt password)
- Optionally: UserPointsBalance

### Transaction Tests Need:
- Mall, Category, Shop, Tier, User
- Optionally: UserPointsBalance for point operations

### Stamp/StampCard Tests Need:
- Mall, Category, Shop
- Stamp (stamps_required must be > 0)
- User

### Offer Tests Need:
- Mall, Category, Shop
- Offer (reward_type required, reward_value optional jsonb)

## Validation Rules by Model

| Model | Validations |
|-------|-------------|
| Mall | name, location presence |
| MallAdmin | email, phone, name presence; email, phone uniqueness |
| Category | mall_id, name, description, icon_url presence |
| Shop | name presence + uniqueness; mall_id, category_id, bio, logo_url, cover_image_url presence |
| ShopAdmin | shop_id, name, email, phone presence; email, phone uniqueness |
| User | tier_id, first_name, last_name, email, phone, gender, password_hash presence; email, phone uniqueness |
| Tier | name presence + uniqueness; icon_url presence |
| EarnTransaction | user_id, shop_id presence; PurchaseAmount, PurchaseCurrency defaults |
| RedeemTransaction | user_id, shop_id, points_used presence; verification_code unique 6 chars; status enum |
| Receipt | user_id, shop_id, receipt_path, receipt_details presence; Amount, Currency defaults |
| Offer | shop_id, name, description, image_url, reward_type presence |
| Stamp | shop_id, name, description, image_url, stamp_icon_url, reward_type, stamps_required presence; stamps_required > 0 |
| UserStampCard | user_id, stamp_id presence (composite PK) |
| SystemConfig | mall_id presence; one config per mall |

## Common Test Assertions

```ruby
# Model
assert_difference "Model.count", 1 do ... end
assert_difference "Model.count", -1 do ... end
refute @model.save
assert @model.errors[:field].any?

# Controller
assert_response :success
assert_response :redirect
assert_redirected_to model_url(@model)
assert_redirected_to login_path

# Session
get shops_url
assert_redirected_to mall_admins_login_path
```

## Services to Test

### SupabaseStorageService
```ruby
SupabaseStorageService.upload(file, path)
# Returns public URL string on success, nil on failure
# Uses ENV["SUPABASE_SERVICE_ROLE_KEY"]
# Target bucket: "images"
```

## Tips for Writing Passing Tests

1. **Fixtures are commented out** - Create test data in setup blocks
2. **UUID primary keys** - Let database generate or use SecureRandom.uuid
3. **Password hashing** - Use `password: "plaintext"` with has_secure_password
4. **Session auth** - Post to login endpoint before accessing protected routes
5. **CanCanCan abilities** - Admin must have correct role to access resources
6. **Unique constraints** - Use unique names/emails per test with SecureRandom
7. **Foreign keys** - Always create parent records first
8. **JSONB columns** - Use Hash for social_links, receipt_details, reward_value, metadata, benefits
9. **Enums** - status field accepts strings: "pending", "verified", "cancelled" for RedeemTransaction; "pending", "approved", "rejected" for Receipt
10. **Virtual attributes** - Shop has logo_file, cover_image_file (not persisted)
11. **Custom timestamps** - UserPointsBalance, Qr have non-standard timestamp behavior

## Example: Complete Model Test

```ruby
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @tier = Tier.create!(
      name: "Bronze #{SecureRandom.uuid}",
      points_required: 0,
      tier_order: 1,
      icon_url: "https://example.com/icon.png"
    )
  end

  test "valid user creation with has_secure_password" do
    user = User.new(
      tier: @tier,
      first_name: "John",
      last_name: "Doe",
      email: "john#{SecureRandom.uuid}@test.com",
      phone: "1234567890",
      password: "password123",
      gender: "male"
    )
    assert user.save
    assert user.authenticate("password123")
  end

  test "email uniqueness" do
    User.create!(
      tier: @tier,
      first_name: "John",
      last_name: "Doe",
      email: "duplicate@test.com",
      phone: "1234567891",
      password: "password123",
      gender: "male"
    )
    user2 = User.new(
      tier: @tier,
      first_name: "Jane",
      last_name: "Doe",
      email: "duplicate@test.com",
      phone: "1234567892",
      password: "password123",
      gender: "female"
    )
    refute user2.save
    assert user2.errors[:email].any?
  end

  test "required fields" do
    user = User.new
    refute user.save
    assert user.errors[:first_name].any?
    assert user.errors[:last_name].any?
    assert user.errors[:email].any?
    assert user.errors[:phone].any?
    assert user.errors[:tier_id].any?
  end
end
```

## Example: Complete Controller Test

```ruby
require "test_helper"

class EarnTransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @mall = Mall.create!(name: "Test Mall", location: "Location")
    @category = Category.create!(
      mall: @mall,
      name: "Test Category",
      description: "Desc",
      icon_url: "http://example.com/icon.png"
    )
    @shop = Shop.create!(
      mall: @mall,
      category: @category,
      name: "Test Shop #{SecureRandom.uuid}",
      bio: "Bio",
      logo_url: "logo.png",
      cover_image_url: "cover.png"
    )
    @tier = Tier.create!(
      name: "Test Tier #{SecureRandom.uuid}",
      points_required: 0,
      tier_order: 1,
      icon_url: "http://example.com/icon.png"
    )
    @user = User.create!(
      tier: @tier,
      first_name: "Test",
      last_name: "User",
      email: "user#{SecureRandom.uuid}@test.com",
      phone: "1234567890",
      password: "password123",
      gender: "male"
    )
    @shop_admin = ShopAdmin.create!(
      shop: @shop,
      name: "Shop Admin",
      email: "shop#{SecureRandom.uuid}@test.com",
      phone: "1234567891",
      password: "password123"
    )
  end

  test "shop admin can create earn transaction" do
    post shop_admins_login_url, params: {
      email: @shop_admin.email,
      password: "password123"
    }

    assert_difference "EarnTransaction.count", 1 do
      post earn_transactions_url, params: {
        earn_transaction: {
          user_id: @user.id,
          shop_id: @shop.id,
          purchase_amount: 100.00,
          points_earned: 100
        }
      }
    end
    assert_redirected_to earn_transaction_url(EarnTransaction.last)
  end

  test "unauthenticated cannot access" do
    get earn_transactions_url
    assert_redirected_to shop_admins_login_path
  end
end
```

## Checklist for AI Test Writer

- [ ] All models have unit tests covering validations
- [ ] All controllers have integration tests for CRUD operations
- [ ] Authentication is tested for each controller type
- [ ] Authorization (CanCanCan) is tested
- [ ] Unique constraints are tested
- [ ] Required field validations are tested
- [ ] Associations are properly set up
- [ ] Fixtures/manual creation uses unique values (SecureRandom.uuid)
- [ ] Password authentication works with has_secure_password
- [ ] Enum values are tested
- [ ] JSONB columns are tested
- [ ] All tests pass with `rails test`
