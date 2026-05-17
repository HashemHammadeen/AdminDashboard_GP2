require "test_helper"

class EarnTransactionTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  test "valid earn transaction creation" do
    tx = EarnTransaction.new(
      user: @user,
      shop: @shop,
      PurchaseAmount: 50.00,
      points_earned: 50
    )
    assert tx.save
  end

  test "user foreign key is required" do
    assert_raises(ActiveRecord::NotNullViolation, ActiveRecord::RecordInvalid) do
      EarnTransaction.create!(shop: @shop, PurchaseAmount: 50.00, points_earned: 50)
    end
  end

  test "shop foreign key is required" do
    assert_raises(ActiveRecord::NotNullViolation, ActiveRecord::RecordInvalid) do
      EarnTransaction.create!(user: @user, PurchaseAmount: 50.00, points_earned: 50)
    end
  end

  test "belongs to user and shop" do
    tx = EarnTransaction.create!(user: @user, shop: @shop, PurchaseAmount: 100.00, points_earned: 100)
    assert_equal @user, tx.user
    assert_equal @shop, tx.shop
  end

  test "alias purchase_amount works" do
    tx = EarnTransaction.create!(user: @user, shop: @shop, PurchaseAmount: 75.50, points_earned: 75)
    assert_equal 75.50, tx.purchase_amount.to_f
  end
end
