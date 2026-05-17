require "test_helper"
require_relative "malls_controller_test"

class MallAdminsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
  end

  test "unauthenticated redirects to login" do
    get mall_admins_url
    assert_redirected_to root_path
  end

  test "mall admin can list mall admins" do
    login_as_mall_admin(@mall_admin)
    get mall_admins_url
    assert_response :success
  end

  test "mall admin can view their own profile" do
    login_as_mall_admin(@mall_admin)
    get mall_admin_url(@mall_admin)
    assert_response :success
  end

  test "mall admin can update their profile" do
    login_as_mall_admin(@mall_admin)
    patch mall_admin_url(@mall_admin), params: { mall_admin: { name: "Updated Name" } }
    assert_redirected_to mall_admin_url(@mall_admin)
  end

  test "mall admin can create a new mall admin" do
    login_as_mall_admin(@mall_admin)
    assert_difference "MallAdmin.count", 1 do
      post mall_admins_url, params: {
        mall_admin: {
          mall_id: @mall.id,
          name: "New Admin",
          email: "new#{SecureRandom.uuid}@test.com",
          phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
  end
end
