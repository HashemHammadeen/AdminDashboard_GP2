# Seeds for Mall Management Dashboard
# Run: rails db:seed

puts "🌱 Seeding database..."

# --- Tiers ---
bronze = Tier.find_or_create_by!(tier_name: "Bronze") do |t|
  t.points_required = 0
  t.color_hex = "#CD7F32"
end
silver = Tier.find_or_create_by!(tier_name: "Silver") do |t|
  t.points_required = 500
  t.color_hex = "#C0C0C0"
end
gold = Tier.find_or_create_by!(tier_name: "Gold") do |t|
  t.points_required = 2000
  t.color_hex = "#FFD700"
end
puts "  ✓ #{Tier.count} tiers"

# --- Categories ---
food    = Category.find_or_create_by!(category_name: "Food & Beverage") { |c| c.display_order = 1; c.description = "Restaurants, cafés, and food courts" }
fashion = Category.find_or_create_by!(category_name: "Fashion") { |c| c.display_order = 2; c.description = "Clothing, shoes, and accessories" }
electronics = Category.find_or_create_by!(category_name: "Electronics") { |c| c.display_order = 3; c.description = "Gadgets and tech stores" }
puts "  ✓ #{Category.count} categories"

# --- Malls ---
mall1 = Mall.find_or_create_by!(mall_name: "City Mall") { |m| m.location = "Downtown, Amman" }
mall2 = Mall.find_or_create_by!(mall_name: "Sunset Mall") { |m| m.location = "West Amman" }
puts "  ✓ #{Mall.count} malls"

# --- Mall Admins ---
ma1 = MallAdmin.find_by(email: "mall@admin.com") || MallAdmin.find_by(phone: "0791234567")
unless ma1
  ma1 = MallAdmin.create!(
    email: "mall@admin.com",
    password: "password123",
    password_confirmation: "password123",
    name: "Admin User",
    phone: "0791234567",
    mall: mall1
  )
end
puts "  ✓ MallAdmin: mall@admin.com / password123"

# --- Shops ---
shop1 = Shop.find_or_create_by!(name: "Burger House") do |s|
  s.mall = mall1
  s.category = food
  s.bio = "Best burgers in town"
  s.is_active = true
end
shop2 = Shop.find_or_create_by!(name: "Tech Zone") do |s|
  s.mall = mall1
  s.category = electronics
  s.bio = "Latest gadgets and accessories"
  s.is_active = true
end
shop3 = Shop.find_or_create_by!(name: "Fashion Hub") do |s|
  s.mall = mall2
  s.category = fashion
  s.bio = "Trendy clothing for all ages"
  s.is_active = true
end
puts "  ✓ #{Shop.count} shops"

# --- Shop Admins ---
sa1 = ShopAdmin.find_by(email: "shop@admin.com") || ShopAdmin.find_by(phone: "0797654321")
unless sa1
  sa1 = ShopAdmin.create!(
    email: "shop@admin.com",
    password: "password123",
    password_confirmation: "password123",
    name: "Shop Manager",
    phone: "0797654321",
    shop: shop1
  )
end
puts "  ✓ ShopAdmin: shop@admin.com / password123"

# --- System Config ---
SystemConfig.find_or_create_by!(id: 1) do |sc|
  sc.earn_points_per_currency = 1.0
  sc.min_redemption_threshold = 100
  sc.points_to_currency_ratio = 0.01
end
puts "  ✓ SystemConfig"

# --- Users ---
user1 = User.find_or_create_by!(email: "john@example.com") do |u|
  u.firstname = "John"
  u.lastname = "Doe"
  u.phone = "0771111111"
  u.gender = "male"
  u.password = "password"
  u.tier = bronze
end
user2 = User.find_or_create_by!(email: "jane@example.com") do |u|
  u.firstname = "Jane"
  u.lastname = "Smith"
  u.phone = "0772222222"
  u.gender = "female"
  u.password = "password"
  u.tier = silver
end
puts "  ✓ #{User.count} users"

# --- Earn Transactions ---
3.times do |i|
  EarnTransaction.find_or_create_by!(transaction_ref: "EARN-00#{i+1}") do |et|
    et.user = user1
    et.shop = shop1
    et.purchase_amount = (10 + rand(90)).round(2)
    et.points_earned = (et.purchase_amount * 1).to_i
  end
end
puts "  ✓ #{EarnTransaction.count} earn transactions"

# --- Receipts ---
receipt1 = Receipt.find_or_create_by!(user: user1, shop: shop1, amount: 45.50) do |r|
  r.status = "approved"
  r.receipt_details = { items: ["Burger", "Fries", "Soda"] }
end
receipt2 = Receipt.find_or_create_by!(user: user2, shop: shop1, amount: 22.00) do |r|
  r.status = "pending"
  r.receipt_details = { items: ["Wrap", "Juice"] }
end
puts "  ✓ #{Receipt.count} receipts"

# --- Offers ---
offer1 = Offer.find_or_create_by!(name: "Buy 1 Get 1", shop: shop1) do |o|
  o.description = "Buy one burger, get one free!"
  o.reward_type = "bogo"
  o.active = true
  o.start_date = 1.week.ago
  o.end_date = 1.month.from_now
end
puts "  ✓ #{Offer.count} offers"

# --- Stamps ---
stamp1 = Stamp.find_or_create_by!(name: "Coffee Lover", shop: shop1) do |s|
  s.description = "Collect 10 stamps for a free meal"
  s.stamps_required = 10
  s.reward_type = "free_item"
  s.active = true
  s.start_date = Time.current
  s.end_date = 3.months.from_now
end
puts "  ✓ #{Stamp.count} stamps"

# --- User Points Balances ---
UserPointsBalance.find_or_create_by!(user_id: user1.id) do |upb|
  upb.total_points = 150
  upb.lifetime_points = 350
end
puts "  ✓ #{UserPointsBalance.count} user points balances"

puts "\n🎉 Seeding complete!\n"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  Mall Admin Login: mall@admin.com / password123"
puts "  Shop Admin Login: shop@admin.com / password123"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
