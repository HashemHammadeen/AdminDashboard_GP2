require "test_helper"

class EarnTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earn_transaction = earn_transactions(:one)
  end

  test "should get index" do
    get earn_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_earn_transaction_url
    assert_response :success
  end

  test "should create earn_transaction" do
    assert_difference("EarnTransaction.count") do
      post earn_transactions_url, params: { earn_transaction: { points_earned: @earn_transaction.points_earned, purchase_amount: @earn_transaction.purchase_amount, shop_id: @earn_transaction.shop_id, transaction_ref: @earn_transaction.transaction_ref, user_id: @earn_transaction.user_id } }
    end

    assert_redirected_to earn_transaction_url(EarnTransaction.last)
  end

  test "should show earn_transaction" do
    get earn_transaction_url(@earn_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_earn_transaction_url(@earn_transaction)
    assert_response :success
  end

  test "should update earn_transaction" do
    patch earn_transaction_url(@earn_transaction), params: { earn_transaction: { points_earned: @earn_transaction.points_earned, purchase_amount: @earn_transaction.purchase_amount, shop_id: @earn_transaction.shop_id, transaction_ref: @earn_transaction.transaction_ref, user_id: @earn_transaction.user_id } }
    assert_redirected_to earn_transaction_url(@earn_transaction)
  end

  test "should destroy earn_transaction" do
    assert_difference("EarnTransaction.count", -1) do
      delete earn_transaction_url(@earn_transaction)
    end

    assert_redirected_to earn_transactions_url
  end
end
