require 'bcrypt'
require 'faker'

puts "Starting database seed process..."

def bcrypt(plain)
  BCrypt::Password.create(plain)
end

default_password = bcrypt("password123")

# ==============================================================
# 1. Tiers
# ==============================================================
puts "Creating Tiers..."
tiers_data = [
  { name: "Bronze", points_required: 0, tier_order: 1, color_hex: "#CD7F32", icon_url: "https://example.com/bronze.png", benefits: {"discount"=> "5%", "free_shipping"=> false} },
  { name: "Silver", points_required: 1000, tier_order: 2, color_hex: "#C0C0C0", icon_url: "https://example.com/silver.png", benefits: {"discount"=> "10%", "free_shipping"=> true} },
  { name: "Gold", points_required: 5000, tier_order: 3, color_hex: "#FFD700", icon_url: "https://example.com/gold.png", benefits: {"discount"=> "15%", "free_shipping"=> true, "vip_access"=> true} },
  { name: "Platinum", points_required: 15000, tier_order: 4, color_hex: "#E5E4E2", icon_url: "https://example.com/platinum.png", benefits: {"discount"=> "20%", "free_shipping"=> true, "vip_access"=> true, "valet"=> true} }
]

tiers = tiers_data.map do |td|
  Tier.find_or_create_by!(name: td[:name]) do |t|
    t.assign_attributes(td.except(:name))
  end
end

# ==============================================================
# 2. Malls
# ==============================================================
puts "Creating Malls..."
malls_data = [
  { name: "Mecca Mall", location: "Zahran Street, Amman", cover_image_url: "https://example.com/mecca_cover.png", logo_url: "https://example.com/mecca_logo.png" },
  { name: "Zara Mall", location: "7th Circle, Amman", cover_image_url: "https://example.com/zara_cover.png", logo_url: "https://example.com/zara_logo.png" },
  { name: "Taj Mall", location: "Abdoun, Amman", cover_image_url: "https://example.com/taj_cover.png", logo_url: "https://example.com/taj_logo.png" }
]

malls = malls_data.map do |md|
  Mall.find_or_create_by!(name: md[:name]) do |m|
    m.assign_attributes(md.except(:name))
  end
end

# ==============================================================
# 3. Mall Admins
# ==============================================================
puts "Creating Mall Admins..."
mall_admins = malls.map.with_index do |mall, idx|
  MallAdmin.find_or_create_by!(email: "malladmin#{idx + 1}@example.com") do |a|
    a.name = "Admin of #{mall.name}"
    a.phone = "+96261000#{idx + 10}"
    a.mall = mall
    a.password_hash = default_password
  end
end

# ==============================================================
# 4. System Configs
# ==============================================================
puts "Creating System Configs..."
malls.each_with_index do |mall, idx|
  SystemConfig.find_or_create_by!(mall_id: mall.id) do |sc|
    sc.earn_points_per_currency = rand(5.0..15.0).round(2)
    sc.min_redemption_threshold = 100
    sc.points_to_currency_ratio = 0.05
    sc.updated_by_admin_id = mall_admins[idx].id
    sc.updated_at = Time.current
  end
end

# ==============================================================
# 5. Categories
# ==============================================================
puts "Creating Categories..."
category_names = ["Fashion", "Food & Beverage", "Electronics", "Grocery", "Sports", "Cosmetics", "Entertainment"]
categories_by_mall = {}
malls.each do |mall|
  categories_by_mall[mall.id] = category_names.map.with_index do |cname, idx|
    Category.find_or_create_by!(name: cname, mall: mall) do |c|
      c.description = "#{cname} shops in #{mall.name}"
      c.display_order = idx + 1
      c.icon_url = "https://example.com/icon_#{cname.downcase.gsub(' & ', '_')}.png"
    end
  end
end

# ==============================================================
# 6. Shops, Shop Admins, and Wallets
# ==============================================================
puts "Creating Shops, Shop Admins, and Wallets..."
all_shops = []
shop_admins = []
malls.each do |mall|
  cats = categories_by_mall[mall.id]
  15.times do |i|
    cat = cats.sample
    shop_name = "#{Faker::Company.name} #{mall.name.split.first}"
    
    shop = Shop.find_or_create_by!(name: "#{shop_name} #{i}", mall: mall) do |s|
      s.bio = Faker::Company.catch_phrase
      s.category = cat
      s.cover_image_url = Faker::Internet.url(path: '/cover.png')
      s.logo_url = Faker::Internet.url(path: '/logo.png')
      s.is_active = true
      s.website_url = Faker::Internet.url
      s.social_links = { facebook: Faker::Internet.url, instagram: Faker::Internet.url }
    end
    all_shops << shop
    
    ShopPointsWallet.find_or_create_by!(shop_id: shop.id) do |w|
      w.points_received = rand(0..10000)
      w.last_updated = Time.current
    end
    
    admin_email = "shopadmin_#{shop.id.split('-').first}@example.com"
    shop_admins << ShopAdmin.find_or_create_by!(email: admin_email) do |a|
      a.name = Faker::Name.name
      a.phone = "+96279#{rand(100000..999999)}#{i}"
      a.shop = shop
      a.password_hash = default_password
      a.is_active = true
    end
  end
end

# Ensure we have consistent credentials for testing
unless ShopAdmin.find_by(email: "shopadmin@example.com")
  first_shop = all_shops.first
  ShopAdmin.create!(
    email: "shopadmin@example.com",
    name: "Master Shop Admin",
    phone: "+962799999999",
    shop: first_shop,
    password_hash: default_password,
    is_active: true
  )
end

# ==============================================================
# 7. Users and User Points Balances
# ==============================================================
puts "Creating Users and User Points Balances..."
users = 150.times.map do |i|
  tier = tiers.sample
  u = User.find_or_create_by!(email: "user_#{i}_#{Faker::Internet.email}") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.phone = "+96277#{rand(1000000..9999999)}#{i}"
    user.gender = ["male", "female"].sample
    user.password_hash = default_password
    user.tier = tier
    user.profile_image_url = Faker::Avatar.image
  end
  
  UserPointsBalance.find_or_create_by!(user: u) do |upb|
    upb.total_points = rand(50..25000)
    upb.lifetime_points = rand(25000..100000)
  end
  u
end

unless User.find_by(email: "user@example.com")
  u = User.create!(
    email: "user@example.com",
    first_name: "Demo",
    last_name: "User",
    phone: "+962770000000",
    gender: "male",
    password_hash: default_password,
    tier: tiers.first,
    profile_image_url: Faker::Avatar.image
  )
  UserPointsBalance.create!(
    user: u,
    total_points: 15000,
    lifetime_points: 50000
  )
  users << u
end

# ==============================================================
# 8. Offers
# ==============================================================
puts "Creating Offers..."
offers = []
all_shops.each do |shop|
  rand(3..6).times do
    offers << Offer.create!(
      name: "#{rand(10..50)}% Off #{Faker::Commerce.department}",
      description: Faker::Marketing.buzzwords,
      shop: shop,
      image_url: Faker::Internet.url(path: '/offer.png'),
      reward_type: ["Percentage Discount", "Fixed Amount", "Free Item"].sample,
      reward_value: { value: rand(10..50) },
      is_active: true,
      start_date: Faker::Time.backward(days: 30),
      end_date: Faker::Time.forward(days: 60)
    )
  end
end

# ==============================================================
# 9. Stamps
# ==============================================================
puts "Creating Stamps..."
stamps = []
all_shops.each do |shop|
  rand(1..3).times do
    stamps << Stamp.create!(
      name: "#{shop.name} Loyalty Program",
      description: "Buy #{rand(5..10)} get 1 free",
      shop: shop,
      image_url: Faker::Internet.url(path: '/stamp_cover.png'),
      stamp_icon_url: Faker::Internet.url(path: '/stamp_icon.png'),
      stamps_required: rand(5..12),
      reward_type: "Free Coffee",
      is_active: true,
      start_date: Faker::Time.backward(days: 30),
      end_date: Faker::Time.forward(days: 365)
    )
  end
end

# ==============================================================
# 10. QRs
# ==============================================================
puts "Creating QRs..."
qrs = []
users.sample(100).each do |user|
  shop = all_shops.sample
  qrs << Qr.create!(
    user: user,
    shop: shop,
    qr_code_data: { type: "redeem", value: "some_data" },
    expires_at: Faker::Time.forward(days: 1)
  )
end

# ==============================================================
# 11. Receipts
# ==============================================================
puts "Creating Receipts..."
receipts = []
users.sample(100).each do |user|
  shop = all_shops.sample
  receipts << Receipt.create!(
    user: user,
    shop: shop,
    amount: rand(15.0..500.0).round(2),
    receipt_currency: "JOD",
    receipt_path: "uploads/receipts/#{SecureRandom.hex(8)}.jpg",
    status: ["pending", "approved", "rejected"].sample,
    receipt_details: { items: rand(1..5) }
  )
end

# ==============================================================
# 12. Earn Transactions
# ==============================================================
puts "Creating Earn Transactions..."
earn_txns = []
users.sample(150).each do |user|
  rand(1..4).times do
    shop = all_shops.sample
    earn_txns << EarnTransaction.create!(
      user: user,
      shop: shop,
      purchase_amount: rand(10.0..300.0).round(2),
      purchase_currency: "JOD",
      points_earned: rand(10..500),
      transaction_ref: SecureRandom.hex(10),
      created_at: Faker::Time.backward(days: 60)
    )
  end
end

# ==============================================================
# 13. Redeem Transactions
# ==============================================================
puts "Creating Redeem Transactions..."
redeem_txns = []
users.sample(100).each do |user|
  shop = all_shops.sample
  redeem_txns << RedeemTransaction.create!(
    user: user,
    shop: shop,
    points_used: rand(100..2000),
    discount_value: rand(5.0..50.0).round(2),
    discount_currency: "JOD",
    verification_code: Array.new(6){rand(10)}.join,
    status: "verified",
    completed_at: Faker::Time.backward(days: 30),
    created_at: Faker::Time.backward(days: 30)
  )
end

# ==============================================================
# 14. Offer Redemptions
# ==============================================================
puts "Creating Offer Redemptions..."
offers.sample(80).each do |offer|
  user = users.sample
  receipt = receipts.sample
  OfferRedemption.create!(
    offer: offer,
    user: user,
    shop: offer.shop,
    redemption_ref: qrs.sample.qr_id,
    created_at: Faker::Time.backward(days: 30)
  )
end

# ==============================================================
# 15. User Stamp Cards
# ==============================================================
puts "Creating User Stamp Cards..."
user_stamp_cards = []
stamps.sample(100).each do |stamp|
  user = users.sample
  # Avoid duplicate unique keys (user_id, stamp_id)
  next if UserStampCard.exists?(user_id: user.user_id, stamp_id: stamp.stamp_id)
  
  user_stamp_cards << UserStampCard.create!(
    user: user,
    stamp: stamp,
    stamps_counter: rand(0..stamp.stamps_required),
    is_completed: [true, false].sample,
    last_transaction: Faker::Time.backward(days: 10)
  )
end

# ==============================================================
# 16. Stamp Transactions
# ==============================================================
puts "Creating Stamp Transactions..."
stamps.sample(100).each do |stamp|
  user = users.sample
  StampTransaction.create!(
    stamp_program_id: stamp.stamp_id,
    user: user,
    shop: stamp.shop,
    type: ["collect", "redeem"].sample,
    stamps_count: 1,
    redemption_ref: nil,
    created_at: Faker::Time.backward(days: 30)
  )
end

# ==============================================================
# 17. Stamp Redemptions
# ==============================================================
puts "Creating Stamp Redemptions..."
qrs.select { |q| q.user_id && q.shop_id }.take(30).each do |qr|
  stamp = stamps.select { |s| s.shop_id == qr.shop_id }.sample
  next unless stamp
  # Avoid uniqueness conflicts
  next if StampRedemption.exists?(redemption_ref: qr.qr_id)
  
  StampRedemption.create!(
    redemption_ref: qr.qr_id,
    shop_id: qr.shop_id,
    stamp_id: stamp.id,
    user_id: qr.user_id
  )
end

# ==============================================================
# 18. Audit Logs
# ==============================================================
puts "Creating Audit Logs..."
200.times do
  mall_admin = mall_admins.sample
  AuditLog.create!(
    action_type: ["config_update", "user_tier_change", "shop_deactivated"].sample,
    mall_admin_id: mall_admin.id,
    user_id: [nil, users.sample.id].sample,
    shop_id: [nil, all_shops.sample.id].sample,
    points: [nil, rand(-500..500)].sample,
    metadata: { note: "Generated by seed" }
  )
end

puts ""
puts "=============================================================="
puts "Seeding complete! Credentials:"
puts "  Mall Admins:"
mall_admins.take(3).each { |ma| puts "    #{ma.email} (password: password123)" }
puts "  Shop Admins:"
puts "    shopadmin@example.com (password: password123)"
shop_admins.take(2).each { |sa| puts "    #{sa.email} (password: password123)" }
puts "  Users:"
puts "    user@example.com (password: password123)"
puts "=============================================================="
