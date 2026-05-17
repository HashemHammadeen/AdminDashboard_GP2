require "test_helper"

class ShopAdminTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
  end

  test "valid shop admin creation" do
    sa = ShopAdmin.new(
      shop: @shop,
      name: "Shop Admin",
      email: "sa#{SecureRandom.uuid}@test.com",
      phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
      password: "password123"
    )
    assert sa.save
  end

  test "email is required" do
    sa = ShopAdmin.new(shop: @shop, name: "Admin", phone: "0799999999", password: "password123")
    refute sa.save
    assert sa.errors[:email].any?
  end

  test "phone must be unique" do
    phone = "07#{SecureRandom.uuid[0..7].gsub("-", "")}"
    ShopAdmin.create!(shop: @shop, name: "A1", email: "e1#{SecureRandom.uuid}@test.com", phone: phone, password: "password123")
    sa2 = ShopAdmin.new(shop: @shop, name: "A2", email: "e2#{SecureRandom.uuid}@test.com", phone: phone, password: "password123")
    refute sa2.save
    assert sa2.errors[:phone].any?
  end

  test "has_secure_password authentication" do
    sa = ShopAdmin.create!(
      shop: @shop,
      name: "SA",
      email: "sa_auth#{SecureRandom.uuid}@test.com",
      phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
      password: "secret123"
    )
    assert sa.authenticate("secret123")
    assert_not sa.authenticate("wrong")
  end

  test "belongs to shop" do
    sa = ShopAdmin.create!(shop: @shop, name: "SA", email: "sa#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123")
    assert_equal @shop, sa.shop
  end
end
