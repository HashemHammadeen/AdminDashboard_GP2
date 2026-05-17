require "test_helper"

class RedeemTransactionTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  # DiscountAmount has NOT NULL in DB so we always supply it
  def build_tx(status: "pending")
    RedeemTransaction.new(
      user: @user,
      shop: @shop,
      points_used: 100,
      DiscountAmount: 1.00,
      verification_code: SecureRandom.hex(3).upcase,
      status: status
    )
  end

  test "valid redeem transaction creation" do
    assert build_tx.save
  end

  test "status enum - pending" do
    tx = build_tx(status: "pending")
    tx.save!
    assert tx.pending?
  end

  test "status enum - verified" do
    tx = build_tx(status: "verified")
    tx.save!
    assert tx.verified?
  end

  test "status enum - cancelled" do
    tx = build_tx(status: "cancelled")
    tx.save!
    assert tx.cancelled?
  end

  test "shop foreign key is required" do
    assert_raises(ActiveRecord::NotNullViolation, ActiveRecord::RecordInvalid) do
      RedeemTransaction.create!(user: @user, points_used: 100, DiscountAmount: 1.00, verification_code: SecureRandom.hex(3).upcase)
    end
  end

  test "alias discount_value works" do
    tx = RedeemTransaction.create!(user: @user, shop: @shop, points_used: 100, DiscountAmount: 2.50, verification_code: SecureRandom.hex(3).upcase, status: "pending")
    assert_equal 2.50, tx.discount_value.to_f
  end
end
