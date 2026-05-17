require "test_helper"
require_relative "malls_controller_test"

class ShopAdminsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @mall_admin = create_mall_admin(@mall)
    @shop_admin = create_shop_admin(@shop)
  end

  test "unauthenticated redirects to login" do
    get shop_admins_url
    assert_redirected_to root_path
  end

  test "mall admin can list shop admins" do
    login_as_mall_admin(@mall_admin)
    get shop_admins_url
    assert_response :success
  end

  test "mall admin can view a shop admin" do
    login_as_mall_admin(@mall_admin)
    get shop_admin_url(@shop_admin)
    assert_response :success
  end

  test "mall admin can create a shop admin" do
    login_as_mall_admin(@mall_admin)
    assert_difference "ShopAdmin.count", 1 do
      post shop_admins_url, params: {
        shop_admin: {
          shop_id: @shop.id,
          name: "New Shop Admin",
          email: "nsa#{SecureRandom.uuid}@test.com",
          phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
  end

  test "shop admin can update own profile" do
    login_as_shop_admin(@shop_admin)
    patch shop_admin_url(@shop_admin), params: {
      shop_admin: {
        name: "Updated Name",
        email: "updated#{SecureRandom.uuid}@test.com",
        phone: "0799999999"
      }
    }
    assert_redirected_to shop_admins_path
    @shop_admin.reload
    assert_equal "Updated Name", @shop_admin.name
  end

  test "mall admin can update a shop admin" do
    login_as_mall_admin(@mall_admin)
    patch shop_admin_url(@shop_admin), params: {
      shop_admin: {
        name: "Mall Updated",
        email: "mallupdated#{SecureRandom.uuid}@test.com",
        phone: "0788888888"
      }
    }
    assert_redirected_to shop_path(@shop)
    @shop_admin.reload
    assert_equal "Mall Updated", @shop_admin.name
  end

  test "shop admin can login" do
    post shop_admins_login_url, params: { email: @shop_admin.email, password: "password123" }
    assert_redirected_to shop_admin_root_path
  end

  test "shop admin wrong password redirects to login" do
    post shop_admins_login_url, params: { email: @shop_admin.email, password: "wrong" }
    assert_response :unprocessable_entity
  end
end
