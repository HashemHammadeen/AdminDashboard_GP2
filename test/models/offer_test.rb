require "test_helper"

class OfferTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
  end

  test "valid offer creation" do
    offer = Offer.new(
      shop: @shop,
      name: "Summer Sale",
      description: "20% off",
      image_url: "https://example.com/offer.png",
      reward_type: "discount",
      is_active: true
    )
    assert offer.save
  end

  test "belongs to shop" do
    offer = Offer.create!(shop: @shop, name: "O#{SecureRandom.uuid}", description: "Desc", image_url: "img.png", reward_type: "points")
    assert_equal @shop, offer.shop
  end

  test "reward_value can store JSONB" do
    offer = Offer.create!(
      shop: @shop,
      name: "JSONB Offer #{SecureRandom.uuid}",
      description: "Desc",
      image_url: "img.png",
      reward_type: "custom",
      reward_value: { "amount" => 50, "currency" => "JOD" }
    )
    offer.reload
    assert_equal 50, offer.reward_value["amount"]
    assert_equal "JOD", offer.reward_value["currency"]
  end

  test "has many offer_redemptions" do
    offer = Offer.create!(shop: @shop, name: "O#{SecureRandom.uuid}", description: "Desc", image_url: "img.png", reward_type: "points")
    assert_respond_to offer, :offer_redemptions
  end
end
