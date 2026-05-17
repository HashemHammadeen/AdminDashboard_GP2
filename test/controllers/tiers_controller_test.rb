require "test_helper"
require_relative "malls_controller_test"

class TiersControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
    @tier = create_tier
  end

  test "unauthenticated redirects to login" do
    get tiers_url
    assert_redirected_to root_path
  end

  test "mall admin can list tiers" do
    login_as_mall_admin(@mall_admin)
    get tiers_url
    assert_response :success
  end

  test "mall admin can view a tier" do
    login_as_mall_admin(@mall_admin)
    get tier_url(@tier)
    assert_response :success
  end

  test "mall admin can create a tier" do
    login_as_mall_admin(@mall_admin)
    assert_difference "Tier.count", 1 do
      post tiers_url, params: {
        tier: {
          name: "Platinum #{SecureRandom.uuid}",
          points_required: 5000,
          tier_order: 5,
          icon_url: "https://example.com/plat.png"
        }
      }
    end
    assert_redirected_to tier_url(Tier.order(created_at: :desc).first!)
  end

  test "mall admin can update a tier" do
    login_as_mall_admin(@mall_admin)
    patch tier_url(@tier), params: { tier: { points_required: 999 } }
    assert_redirected_to tier_url(@tier)
  end
end
