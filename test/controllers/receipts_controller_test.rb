require "test_helper"
require_relative "malls_controller_test"

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @receipt = Receipt.create!(user: @user, shop: @shop, Amount: 50.00, receipt_path: "r.jpg", receipt_details: {}, status: "pending")
  end

  test "unauthenticated redirects to login" do
    get receipts_url
    assert_redirected_to root_path
  end

  test "shop admin can list receipts" do
    login_as_shop_admin(@shop_admin)
    get receipts_url
    assert_response :success
  end

  test "shop admin can view a receipt" do
    login_as_shop_admin(@shop_admin)
    get receipt_url(@receipt)
    assert_response :success
  end
end
