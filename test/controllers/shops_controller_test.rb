require "test_helper"
require_relative "malls_controller_test"

class ShopsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @mall_admin = create_mall_admin(@mall)
  end

  test "unauthenticated redirects to login" do
    get shops_url
    assert_redirected_to root_path
  end

  test "mall admin can list shops" do
    login_as_mall_admin(@mall_admin)
    get shops_url
    assert_response :success
  end

  test "mall admin can view a shop" do
    login_as_mall_admin(@mall_admin)
    get shop_url(@shop)
    assert_response :success
  end

  test "mall admin can get new shop form" do
    login_as_mall_admin(@mall_admin)
    get new_shop_url
    assert_response :success
  end

  test "mall admin can create a shop" do
    login_as_mall_admin(@mall_admin)
    assert_difference "Shop.count", 1 do
      post shops_url, params: {
        shop: {
          mall_id: @mall.id,
          category_id: @category.id,
          name: "New Shop #{SecureRandom.uuid}",
          bio: "Bio",
          logo_url: "l.png",
          cover_image_url: "c.png"
        }
      }
    end
    assert_redirected_to shop_url(Shop.order(created_at: :desc).first!)
  end

  test "mall admin can edit a shop" do
    login_as_mall_admin(@mall_admin)
    get edit_shop_url(@shop)
    assert_response :success
  end

  test "mall admin can update a shop" do
    login_as_mall_admin(@mall_admin)
    patch shop_url(@shop), params: { shop: { bio: "Updated bio" } }
    assert_redirected_to shop_url(@shop)
  end
end
