require "test_helper"

class RedeemTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redeem_transaction = redeem_transactions(:one)
  end

  test "should get index" do
    get redeem_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_redeem_transaction_url
    assert_response :success
  end

  test "should create redeem_transaction" do
    assert_difference("RedeemTransaction.count") do
      post redeem_transactions_url, params: { redeem_transaction: { completed_at: @redeem_transaction.completed_at, discount_value: @redeem_transaction.discount_value, points_used: @redeem_transaction.points_used, shop_id: @redeem_transaction.shop_id, status: @redeem_transaction.status, user_id: @redeem_transaction.user_id, verification_code: @redeem_transaction.verification_code } }
    end

    assert_redirected_to redeem_transaction_url(RedeemTransaction.last)
  end

  test "should show redeem_transaction" do
    get redeem_transaction_url(@redeem_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_redeem_transaction_url(@redeem_transaction)
    assert_response :success
  end

  test "should update redeem_transaction" do
    patch redeem_transaction_url(@redeem_transaction), params: { redeem_transaction: { completed_at: @redeem_transaction.completed_at, discount_value: @redeem_transaction.discount_value, points_used: @redeem_transaction.points_used, shop_id: @redeem_transaction.shop_id, status: @redeem_transaction.status, user_id: @redeem_transaction.user_id, verification_code: @redeem_transaction.verification_code } }
    assert_redirected_to redeem_transaction_url(@redeem_transaction)
  end

  test "should destroy redeem_transaction" do
    assert_difference("RedeemTransaction.count", -1) do
      delete redeem_transaction_url(@redeem_transaction)
    end

    assert_redirected_to redeem_transactions_url
  end
end
