require "test_helper"
require_relative "malls_controller_test"

class ShopDashboardsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @shop_admin = create_shop_admin(@shop)
  end

  test "unauthenticated redirects to login" do
    get shop_admin_root_url
    assert_redirected_to shop_admins_login_path
  end

  test "shop admin can access their dashboard" do
    login_as_shop_admin(@shop_admin)
    get shop_admin_root_url
    assert_response :success
  end
end
