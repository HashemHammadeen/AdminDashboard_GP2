require "test_helper"
require_relative "malls_controller_test"

class EarnTransactionsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @earn_tx = EarnTransaction.create!(user: @user, shop: @shop, PurchaseAmount: 50.00, points_earned: 50)
  end

  test "unauthenticated redirects to login" do
    get earn_transactions_url
    assert_redirected_to root_path
  end

  test "shop admin can list earn transactions" do
    login_as_shop_admin(@shop_admin)
    get earn_transactions_url
    assert_response :success
  end

  test "shop admin can view an earn transaction" do
    login_as_shop_admin(@shop_admin)
    get earn_transaction_url(@earn_tx)
    assert_response :success
  end

  test "shop admin can create an earn transaction" do
    login_as_shop_admin(@shop_admin)
    assert_difference "EarnTransaction.count", 1 do
      post earn_transactions_url, params: {
        earn_transaction: {
          user_id: @user.id,
          shop_id: @shop.id,
          PurchaseAmount: 100.00,
          points_earned: 100
        }
      }
    end
    assert_redirected_to earn_transaction_url(EarnTransaction.order(created_at: :desc).first!)
  end
end
