require "test_helper"

class ReceiptTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  test "valid receipt creation" do
    receipt = Receipt.new(
      user: @user,
      shop: @shop,
      Amount: 99.99,
      receipt_path: "receipts/test.jpg",
      receipt_details: { "items" => ["item1"] },
      status: "pending"
    )
    assert receipt.save
  end

  test "status enum - pending" do
    r = Receipt.create!(user: @user, shop: @shop, Amount: 10.00, receipt_path: "r.jpg", receipt_details: {}, status: "pending")
    assert r.pending?
  end

  test "status enum - approved" do
    r = Receipt.create!(user: @user, shop: @shop, Amount: 10.00, receipt_path: "r.jpg", receipt_details: {}, status: "approved")
    assert r.approved?
  end

  test "status enum - rejected" do
    r = Receipt.create!(user: @user, shop: @shop, Amount: 10.00, receipt_path: "r.jpg", receipt_details: {}, status: "rejected")
    assert r.rejected?
  end

  test "receipt_details stores JSONB" do
    r = Receipt.create!(user: @user, shop: @shop, Amount: 10.00, receipt_path: "r.jpg", receipt_details: { "store" => "ABC", "items" => 3 }, status: "pending")
    r.reload
    assert_equal "ABC", r.receipt_details["store"]
    assert_equal 3, r.receipt_details["items"]
  end

  test "belongs to user and shop" do
    r = Receipt.create!(user: @user, shop: @shop, Amount: 10.00, receipt_path: "r.jpg", receipt_details: {}, status: "pending")
    assert_equal @user, r.user
    assert_equal @shop, r.shop
  end
end
