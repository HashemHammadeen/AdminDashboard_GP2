require "test_helper"

class OfferRedemptionTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
    @offer = Offer.create!(shop: @shop, name: "Offer #{SecureRandom.uuid}", description: "Desc", image_url: "img.png", reward_type: "points")
  end

  test "valid offer redemption creation" do
    redemption = OfferRedemption.new(user: @user, offer: @offer, shop: @shop)
    assert redemption.save
  end

  test "user is required" do
    redemption = OfferRedemption.new(offer: @offer, shop: @shop)
    refute redemption.save
    assert redemption.errors[:user_id].any?
  end

  test "offer is required" do
    redemption = OfferRedemption.new(user: @user, shop: @shop)
    refute redemption.save
    assert redemption.errors[:offer_id].any?
  end

  test "shop is required" do
    redemption = OfferRedemption.new(user: @user, offer: @offer)
    refute redemption.save
    assert redemption.errors[:shop_id].any?
  end

  test "belongs to user, offer, shop" do
    redemption = OfferRedemption.create!(user: @user, offer: @offer, shop: @shop)
    assert_equal @user, redemption.user
    assert_equal @offer, redemption.offer
    assert_equal @shop, redemption.shop
  end
end
