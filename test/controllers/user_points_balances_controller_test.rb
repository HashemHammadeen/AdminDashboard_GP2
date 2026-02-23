require "test_helper"

class UserPointsBalancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_points_balance = user_points_balances(:one)
  end

  test "should get index" do
    get user_points_balances_url
    assert_response :success
  end

  test "should get new" do
    get new_user_points_balance_url
    assert_response :success
  end

  test "should create user_points_balance" do
    assert_difference("UserPointsBalance.count") do
      post user_points_balances_url, params: { user_points_balance: { lifetime_points: @user_points_balance.lifetime_points, total_points: @user_points_balance.total_points, user_id: @user_points_balance.user_id } }
    end

    assert_redirected_to user_points_balance_url(UserPointsBalance.last)
  end

  test "should show user_points_balance" do
    get user_points_balance_url(@user_points_balance)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_points_balance_url(@user_points_balance)
    assert_response :success
  end

  test "should update user_points_balance" do
    patch user_points_balance_url(@user_points_balance), params: { user_points_balance: { lifetime_points: @user_points_balance.lifetime_points, total_points: @user_points_balance.total_points, user_id: @user_points_balance.user_id } }
    assert_redirected_to user_points_balance_url(@user_points_balance)
  end

  test "should destroy user_points_balance" do
    assert_difference("UserPointsBalance.count", -1) do
      delete user_points_balance_url(@user_points_balance)
    end

    assert_redirected_to user_points_balances_url
  end
end
