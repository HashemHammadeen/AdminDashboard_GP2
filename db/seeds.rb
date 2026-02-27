# Massive Seeds for Subdomain Multi-Tenancy
# Run: rails db:seed

puts "🌱 Clearing existing data..."
AuditLog.delete_all
Receipt.delete_all
Offer.delete_all
OfferRedemption.delete_all
StampTransaction.delete_all
UserStampCard.delete_all
Stamp.delete_all
Qr.delete_all
RedeemTransaction.delete_all
EarnTransaction.delete_all
UserPointsBalance.delete_all
User.delete_all
ShopAdmin.delete_all
MallAdmin.delete_all
Shop.delete_all
Mall.delete_all
Category.delete_all
Tier.delete_all
SystemConfig.delete_all

puts "🌱 Seeding database with massive data block..."

# --- Tiers ---
bronze = Tier.create!(tier_name: "Bronze", points_required: 0, color_hex: "#CD7F32")
silver = Tier.create!(tier_name: "Silver", points_required: 500, color_hex: "#C0C0C0")
gold = Tier.create!(tier_name: "Gold", points_required: 2000, color_hex: "#FFD700")
platinum = Tier.create!(tier_name: "Platinum", points_required: 5000, color_hex: "#E5E4E2")

# --- Categories ---
food    = Category.create!(category_name: "Food & Beverage", display_order: 1, description: "Restaurants, cafés, and food courts")
fashion = Category.create!(category_name: "Fashion", display_order: 2, description: "Clothing, shoes, and accessories")
electronics = Category.create!(category_name: "Electronics", display_order: 3, description: "Gadgets and tech stores")
entertainment = Category.create!(category_name: "Entertainment", display_order: 4, description: "Cinemas, arcades, and family fun")
home = Category.create!(category_name: "Home & Furniture", display_order: 5, description: "Home appliances and furniture")

# --- System Config ---
SystemConfig.create!(id: 1, earn_points_per_currency: 1.0, min_redemption_threshold: 100, points_to_currency_ratio: 0.01)

# Helper method to seed a Mall heavily
def seed_mall_data(mall_name, location, subdomain_prefix)
  puts "\n=============================================="
  puts "Seeding Mall: #{mall_name} (#{subdomain_prefix}.localhost:3000)"
  
  mall = Mall.create!(
    mall_name: mall_name, 
    location: location, 
    subdomain: subdomain_prefix
  )

  # 2 Mall Admins per mall
  2.times do |i|
    MallAdmin.create!(
      email: "admin#{i+1}@#{subdomain_prefix}.com",
      password: "password123",
      password_confirmation: "password123",
      name: "#{mall_name} Admin #{i+1}",
      phone: "079#{rand(1000000..9999999)}",
      mall: mall
    )
  end

  # Pool of 50 users per mall so we can have many transactions
  users = []
  last_names = %w[Smith Johnson Williams Brown Jones Garcia Miller Davis Rodriguez Martinez Hernandez Lopez Gonzalez]
  first_names = %w[James John Robert Michael William David Richard Charles Joseph Thomas Christopher Daniel Paul Mark Donald]
  
  50.times do |i|
    users << User.create!(
      email: "user#{i}_#{subdomain_prefix}@example.com",
      firstname: first_names.sample,
      lastname: last_names.sample,
      phone: "077#{rand(1000000..9999999)}",
      gender: ["male", "female"].sample,
      password: "password123",
      tier: [Tier.find_by(tier_name: "Bronze"), Tier.find_by(tier_name: "Silver"), Tier.find_by(tier_name: "Gold")].sample
    )
    # Give them points
    UserPointsBalance.create!(
      user: users.last,
      total_points: rand(50..1200),
      lifetime_points: rand(100..5000)
    )
  end

  # 3 Shops per mall
  categories = Category.all.to_a
  shops = []
  3.times do |i|
    category = categories.sample
    shop_name = "#{mall_name.split(' ').first} #{category.category_name.split(' ').first} #{%w[Hub Zone Spot Express Center Boutique Max Pro].sample} #{i+1}"
    
    shop = Shop.create!(
      name: shop_name, 
      mall: mall, 
      category: category, 
      bio: "The best #{category.category_name.downcase} experience in #{mall_name}.", 
      is_active: true
    )
    shops << shop

    # 3 Shop Admins per shop
    3.times do |sa_idx|
      ShopAdmin.create!(
        email: "shop#{i+1}_admin#{sa_idx+1}@#{subdomain_prefix}.com",
        password: "password123",
        password_confirmation: "password123",
        name: "#{shop_name} Mgr #{sa_idx+1}",
        phone: "078#{rand(1000000..9999999)}",
        shop: shop
      )
    end

    # QRs for the shop
    3.times do |qr_i|
      Qr.create!(
        user: users.sample,
        shop: shop,
        qr_code_data: "QR-#{shop_name.delete(' ')}-#{qr_i}-#{SecureRandom.hex(4)}",
        expires_at: 1.year.from_now
      )
    end

    # Offers for shop
    offer_types = ["discount", "bogo", "free_item"]
    3.times do |off_i|
      Offer.create!(
        name: "Offer #{off_i+1}: #{%w[Summer Winter Spring Holiday Back-to-School].sample} Special",
        shop: shop,
        description: "Great deals exclusively at #{shop_name}",
        reward_type: offer_types.sample,
        active: true,
        start_date: 1.month.ago,
        end_date: 3.months.from_now
      )
    end

    # Stamp Program for shop
    stamp = Stamp.create!(
      name: "#{shop_name} Loyalty Program",
      shop: shop,
      description: "Buy 10 get 1 free",
      stamps_required: 10,
      reward_type: "free_item",
      active: true,
      start_date: Time.current,
      end_date: 1.year.from_now
    )

    # Fake realistic data: 15 Earn transactions, 5 Redeem transactions, 5 Receipts, 5 Stamp Cards
    20.times do |tx_i|
      txn_user = users.sample
      amount = (rand(10..250) + rand).round(2)
      
      # Earn
      EarnTransaction.create!(
        transaction_ref: "EARN-#{subdomain_prefix.upcase}-#{shop.id}-#{tx_i}-#{SecureRandom.hex(3).upcase}",
        user: txn_user,
        shop: shop,
        purchase_amount: amount,
        points_earned: (amount * 1.0).to_i,
        created_at: rand(1..60).days.ago
      )
    end

    5.times do |rx_i|
      txn_user = users.sample
      pts_redeemed = rand(100..500)
      RedeemTransaction.create!(
        verification_code: SecureRandom.hex(3).upcase,
        user: txn_user,
        shop: shop,
        points_used: pts_redeemed,
        discount_value: pts_redeemed * 0.01,
        status: %w[pending verified cancelled].sample,
        created_at: rand(1..30).days.ago
      )
    end

    5.times do |rcpt_i|
      Receipt.create!(
        user: users.sample,
        shop: shop,
        amount: (rand(5..150) + rand).round(2),
        status: %w[approved pending rejected].sample,
        receipt_details: { items: ["Item 1", "Item 2", "Item 3"].sample(rand(1..3)) },
        created_at: rand(1..10).days.ago
      )
    end

    users.sample(10).each do |u|
      UserStampCard.find_or_create_by!(user: u, stamp: stamp) do |card|
        card.stamps_counter = rand(1..9)
        card.is_completed = false
        card.created_at = rand(1..60).days.ago
      end
    end
  end
  puts "  -> Seeded 2 Mall Admins, #{shops.count} Shops, #{shops.count * 3} Shop Admins, and thousands of data points."
end

# Generate 4 Malls Total
seed_mall_data("City Mall", "Downtown Amman", "mall1")
seed_mall_data("Sunset Mall", "West Amman", "mall2")
seed_mall_data("Taj Lifestyle Center", "Abdoun", "mall3")
seed_mall_data("Mecca Mall", "Mecca Street", "mall4")


puts "\n🎉 MASSIVE SEEDING COMPLETE! 🎉\n"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  Global Portal:  http://localhost:3000"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  MALL 1 (City Mall - mall1.localhost:3000):"
puts "    Mall Admins: admin1@mall1.com, admin2@mall1.com / password123"
puts "    Shop Admins: shop1_admin1@mall1.com ... shop3_admin3@mall1.com / password123"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  MALL 2 (Sunset Mall - mall2.localhost:3000):"
puts "    Mall Admins: admin1@mall2.com, admin2@mall2.com / password123"
puts "    Shop Admins: shop1_admin1@mall2.com ... shop3_admin3@mall2.com / password123"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  MALL 3 (Taj Lifestyle Center - mall3.localhost:3000):"
puts "    Mall Admins: admin1@mall3.com, admin2@mall3.com / password123"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  MALL 4 (Mecca Mall - mall4.localhost:3000):"
puts "    Mall Admins: admin1@mall4.com, admin2@mall4.com / password123"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
