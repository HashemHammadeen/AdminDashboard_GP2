require "test_helper"

class UserStampCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_stamp_card = user_stamp_cards(:one)
  end

  test "should get index" do
    get user_stamp_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_user_stamp_card_url
    assert_response :success
  end

  test "should create user_stamp_card" do
    assert_difference("UserStampCard.count") do
      post user_stamp_cards_url, params: { user_stamp_card: { is_completed: @user_stamp_card.is_completed, last_transaction: @user_stamp_card.last_transaction, stamp_id: @user_stamp_card.stamp_id, stamps_counter: @user_stamp_card.stamps_counter, user_id: @user_stamp_card.user_id } }
    end

    assert_redirected_to user_stamp_card_url(UserStampCard.last)
  end

  test "should show user_stamp_card" do
    get user_stamp_card_url(@user_stamp_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_stamp_card_url(@user_stamp_card)
    assert_response :success
  end

  test "should update user_stamp_card" do
    patch user_stamp_card_url(@user_stamp_card), params: { user_stamp_card: { is_completed: @user_stamp_card.is_completed, last_transaction: @user_stamp_card.last_transaction, stamp_id: @user_stamp_card.stamp_id, stamps_counter: @user_stamp_card.stamps_counter, user_id: @user_stamp_card.user_id } }
    assert_redirected_to user_stamp_card_url(@user_stamp_card)
  end

  test "should destroy user_stamp_card" do
    assert_difference("UserStampCard.count", -1) do
      delete user_stamp_card_url(@user_stamp_card)
    end

    assert_redirected_to user_stamp_cards_url
  end
end
