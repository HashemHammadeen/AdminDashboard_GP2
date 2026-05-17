require "test_helper"
require_relative "malls_controller_test"

class UserPointsBalancesControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
    @tier = create_tier
    @user = create_user(@tier)
    @balance = UserPointsBalance.create!(user: @user, total_points: 500, lifetime_points: 1000)
  end

  test "unauthenticated redirects to login" do
    get user_points_balances_url
    assert_redirected_to root_path
  end

  test "mall admin can list user points balances" do
    login_as_mall_admin(@mall_admin)
    get user_points_balances_url
    assert_response :success
  end

  test "mall admin can view a user points balance" do
    login_as_mall_admin(@mall_admin)
    get user_points_balance_url(@balance)
    assert_response :success
  end
end
