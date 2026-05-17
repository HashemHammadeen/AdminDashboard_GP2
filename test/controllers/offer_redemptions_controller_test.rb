require "test_helper"
require_relative "malls_controller_test"

class OfferRedemptionsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @mall_admin = create_mall_admin(@mall)
    @shop_admin = create_shop_admin(@shop)
    @offer = Offer.create!(shop: @shop, name: "Offer #{SecureRandom.uuid}", description: "Desc", image_url: "img.png", reward_type: "discount")
    @redemption = OfferRedemption.create!(user: @user, offer: @offer, shop: @shop)
  end

  test "unauthenticated redirects to login" do
    get offer_redemptions_url
    assert_redirected_to root_path
  end

  test "shop admin can list offer redemptions" do
    login_as_shop_admin(@shop_admin)
    get offer_redemptions_url
    assert_response :success
  end

  test "shop admin can view an offer redemption" do
    login_as_shop_admin(@shop_admin)
    get offer_redemption_url(@redemption)
    assert_response :success
  end

  test "mall admin can list offer redemptions" do
    login_as_mall_admin(@mall_admin)
    get offer_redemptions_url
    assert_response :success
  end
end
