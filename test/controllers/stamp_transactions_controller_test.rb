require "test_helper"

class StampTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stamp_transaction = stamp_transactions(:one)
  end

  test "should get index" do
    get stamp_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_stamp_transaction_url
    assert_response :success
  end

  test "should create stamp_transaction" do
    assert_difference("StampTransaction.count") do
      post stamp_transactions_url, params: { stamp_transaction: { receipt_id: @stamp_transaction.receipt_id, shop_id: @stamp_transaction.shop_id, stamp_id: @stamp_transaction.stamp_id, stamps_count: @stamp_transaction.stamps_count, transaction_type: @stamp_transaction.transaction_type, user_id: @stamp_transaction.user_id } }
    end

    assert_redirected_to stamp_transaction_url(StampTransaction.last)
  end

  test "should show stamp_transaction" do
    get stamp_transaction_url(@stamp_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_stamp_transaction_url(@stamp_transaction)
    assert_response :success
  end

  test "should update stamp_transaction" do
    patch stamp_transaction_url(@stamp_transaction), params: { stamp_transaction: { receipt_id: @stamp_transaction.receipt_id, shop_id: @stamp_transaction.shop_id, stamp_id: @stamp_transaction.stamp_id, stamps_count: @stamp_transaction.stamps_count, transaction_type: @stamp_transaction.transaction_type, user_id: @stamp_transaction.user_id } }
    assert_redirected_to stamp_transaction_url(@stamp_transaction)
  end

  test "should destroy stamp_transaction" do
    assert_difference("StampTransaction.count", -1) do
      delete stamp_transaction_url(@stamp_transaction)
    end

    assert_redirected_to stamp_transactions_url
  end
end
