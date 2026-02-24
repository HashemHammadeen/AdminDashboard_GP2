require "test_helper"

class MallDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mall_dashboards_show_url
    assert_response :success
  end
end
