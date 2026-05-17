require "test_helper"

class StampTransactionTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
    @stamp = Stamp.create!(
      shop: @shop,
      name: "Stamp #{SecureRandom.uuid}",
      description: "Desc",
      image_url: "img.png",
      stamp_icon_url: "icon.png",
      reward_type: "free_item",
      stamps_required: 5
    )
  end

  test "valid stamp transaction creation" do
    tx = StampTransaction.new(
      user: @user,
      shop: @shop,
      stamp_program: @stamp,
      type: "earn",
      stamps_count: 1
    )
    assert tx.save
  end

  test "belongs to user, shop and stamp_program" do
    tx = StampTransaction.create!(user: @user, shop: @shop, stamp_program: @stamp, type: "earn", stamps_count: 1)
    assert_equal @user, tx.user
    assert_equal @shop, tx.shop
    assert_equal @stamp, tx.stamp_program
  end

  test "stamp alias works" do
    tx = StampTransaction.create!(user: @user, shop: @shop, stamp_program: @stamp, type: "earn", stamps_count: 1)
    assert_equal @stamp, tx.stamp
  end
end
