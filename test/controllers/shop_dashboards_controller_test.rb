require "test_helper"

class ShopDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shop_dashboards_show_url
    assert_response :success
  end
end
