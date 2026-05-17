require "test_helper"
require_relative "malls_controller_test"

class StampTransactionsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @stamp = Stamp.create!(
      shop: @shop, name: "Stamp #{SecureRandom.uuid}", description: "Desc",
      image_url: "img.png", stamp_icon_url: "icon.png", reward_type: "free_item", stamps_required: 5
    )
    @stamp_tx = StampTransaction.create!(user: @user, shop: @shop, stamp_program: @stamp, type: "earn", stamps_count: 1)
  end

  test "unauthenticated redirects to login" do
    get stamp_transactions_url
    assert_redirected_to root_path
  end

  test "shop admin can list stamp transactions" do
    login_as_shop_admin(@shop_admin)
    get stamp_transactions_url
    assert_response :success
  end

  test "shop admin can view a stamp transaction" do
    login_as_shop_admin(@shop_admin)
    get stamp_transaction_url(@stamp_tx)
    assert_response :success
  end
end
