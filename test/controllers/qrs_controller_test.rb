require "test_helper"
require_relative "malls_controller_test"

class QrsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @qr = Qr.create!(user: @user, shop: @shop, qr_code_data: { "type" => "earn" }, expires_at: 1.hour.from_now)
  end

  test "unauthenticated redirects to login" do
    get qrs_url
    assert_redirected_to root_path
  end

  test "shop admin can list qrs" do
    login_as_shop_admin(@shop_admin)
    get qrs_url
    assert_response :success
  end

  test "shop admin can view a qr" do
    login_as_shop_admin(@shop_admin)
    get qr_url(@qr)
    assert_response :success
  end
end
