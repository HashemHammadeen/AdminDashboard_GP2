require "test_helper"
require_relative "malls_controller_test"

class MallDashboardsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
  end

  test "unauthenticated redirects to login" do
    get mall_admin_root_url
    assert_redirected_to mall_admins_login_path
  end

  test "mall admin can access their dashboard" do
    login_as_mall_admin(@mall_admin)
    get mall_admin_root_url
    assert_response :success
  end
end
