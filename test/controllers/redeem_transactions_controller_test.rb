require "test_helper"
require_relative "malls_controller_test"

class RedeemTransactionsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @redeem_tx = RedeemTransaction.create!(user: @user, shop: @shop, points_used: 100, DiscountAmount: 1.00, verification_code: SecureRandom.hex(3).upcase, status: "pending")
  end

  test "unauthenticated redirects to login" do
    get redeem_transactions_url
    assert_redirected_to root_path
  end

  test "shop admin can list redeem transactions" do
    login_as_shop_admin(@shop_admin)
    get redeem_transactions_url
    assert_response :success
  end

  test "shop admin can view a redeem transaction" do
    login_as_shop_admin(@shop_admin)
    get redeem_transaction_url(@redeem_tx)
    assert_response :success
  end

  test "shop admin can create a redeem transaction" do
    login_as_shop_admin(@shop_admin)
    assert_difference "RedeemTransaction.count", 1 do
      post redeem_transactions_url, params: {
        redeem_transaction: {
          user_id: @user.id,
          shop_id: @shop.id,
          points_used: 200,
          DiscountAmount: 1.00,
          verification_code: SecureRandom.hex(3).upcase,
          status: "pending"
        }
      }
    end
    assert_redirected_to redeem_transaction_url(RedeemTransaction.order(created_at: :desc).first!)
  end
end
