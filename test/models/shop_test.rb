require "test_helper"

class ShopTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
  end

  def valid_attrs
    {
      mall: @mall,
      category: @category,
      name: "Shop #{SecureRandom.uuid}",
      bio: "Test bio",
      logo_url: "https://example.com/logo.png",
      cover_image_url: "https://example.com/cover.png"
    }
  end

  test "valid shop creation" do
    shop = Shop.new(valid_attrs)
    assert shop.save
  end

  test "name is required" do
    shop = Shop.new(valid_attrs.merge(name: nil))
    refute shop.save
    assert shop.errors[:name].any?
  end

  test "name must be unique" do
    name = "Unique Shop #{SecureRandom.uuid}"
    Shop.create!(valid_attrs.merge(name: name))
    shop2 = Shop.new(valid_attrs.merge(name: name))
    refute shop2.save
    assert shop2.errors[:name].any?
  end

  test "belongs to mall" do
    shop = Shop.create!(valid_attrs)
    assert_equal @mall, shop.mall
  end

  test "belongs to category" do
    shop = Shop.create!(valid_attrs)
    assert_equal @category, shop.category
  end

  test "has many shop_admins" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :shop_admins
  end

  test "has many offers" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :offers
  end

  test "has many stamps" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :stamps
  end

  test "has many receipts" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :receipts
  end

  test "has many earn_transactions" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :earn_transactions
  end

  test "has many redeem_transactions" do
    shop = Shop.create!(valid_attrs)
    assert_respond_to shop, :redeem_transactions
  end

  test "store_accessor for social_links" do
    shop = Shop.create!(valid_attrs)
    shop.update(social_links: { facebook: "fb.com/shop", instagram: "ig.com/shop", x: "x.com/shop" })
    assert_equal "fb.com/shop", shop.facebook
    assert_equal "ig.com/shop", shop.instagram
    assert_equal "x.com/shop", shop.x
  end

  test "virtual attributes for file uploads" do
    shop = Shop.new(valid_attrs)
    assert_respond_to shop, :logo_file
    assert_respond_to shop, :cover_image_file
  end
end
