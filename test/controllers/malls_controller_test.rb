require "test_helper"

# Shared helper to set up a full test environment
module TestSetupHelper
  def create_mall
    Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Test Location")
  end

  def create_category(mall)
    Category.create!(mall: mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
  end

  def create_shop(mall, category)
    Shop.create!(mall: mall, category: category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
  end

  def create_tier
    Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
  end

  def create_user(tier)
    User.create!(tier: tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  def create_mall_admin(mall)
    MallAdmin.create!(mall: mall, name: "Admin", email: "ma#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123")
  end

  def create_shop_admin(shop)
    ShopAdmin.create!(shop: shop, name: "SA", email: "sa#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123")
  end

  def login_as_mall_admin(admin)
    post mall_admins_login_url, params: { email: admin.email, password: "password123" }
  end

  def login_as_shop_admin(admin)
    post shop_admins_login_url, params: { email: admin.email, password: "password123" }
  end
end

class MallsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
  end

  test "unauthenticated redirects to login" do
    get malls_url
    assert_redirected_to root_path
  end

  test "mall admin can list malls" do
    login_as_mall_admin(@mall_admin)
    get malls_url
    assert_response :success
  end

  test "mall admin can view a mall" do
    login_as_mall_admin(@mall_admin)
    get mall_url(@mall)
    assert_response :success
  end

  test "mall admin cannot get new mall form (cannot create)" do
    login_as_mall_admin(@mall_admin)
    get new_mall_url
    assert_redirected_to root_path
  end

  test "mall admin cannot create a mall (they manage their own)" do
    login_as_mall_admin(@mall_admin)
    assert_no_difference "Mall.count" do
      post malls_url, params: { mall: { name: "New Mall #{SecureRandom.uuid}", location: "New Location" } }
    end
    assert_redirected_to root_path
  end

  test "mall admin can edit a mall" do
    login_as_mall_admin(@mall_admin)
    get edit_mall_url(@mall)
    assert_response :success
  end

  test "mall admin can update a mall" do
    login_as_mall_admin(@mall_admin)
    patch mall_url(@mall), params: { mall: { location: "Updated Location" } }
    assert_redirected_to mall_url(@mall)
  end
end
