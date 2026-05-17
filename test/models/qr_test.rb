require "test_helper"

class QrTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  test "valid qr creation with user and shop" do
    qr = Qr.new(
      user: @user,
      shop: @shop,
      qr_code_data: { "type" => "earn", "shop_id" => @shop.id },
      expires_at: 1.hour.from_now
    )
    assert qr.save
  end

  test "qr with no user or shop (both optional)" do
    qr = Qr.new(
      qr_code_data: { "type" => "generic" },
      expires_at: 1.hour.from_now
    )
    assert qr.save
  end

  test "qr_code_data stores JSONB" do
    qr = Qr.create!(qr_code_data: { "action" => "redeem", "amount" => 100 }, expires_at: 1.hour.from_now)
    qr.reload
    assert_equal "redeem", qr.qr_code_data["action"]
    assert_equal 100, qr.qr_code_data["amount"]
  end

  test "created_at returns Time.current" do
    qr = Qr.create!(qr_code_data: { "x" => 1 }, expires_at: 1.hour.from_now)
    assert_kind_of Time, qr.created_at
  end
end
