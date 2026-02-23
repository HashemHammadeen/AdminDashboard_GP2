require "test_helper"

class OfferRedemptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer_redemption = offer_redemptions(:one)
  end

  test "should get index" do
    get offer_redemptions_url
    assert_response :success
  end

  test "should get new" do
    get new_offer_redemption_url
    assert_response :success
  end

  test "should create offer_redemption" do
    assert_difference("OfferRedemption.count") do
      post offer_redemptions_url, params: { offer_redemption: { offer_id: @offer_redemption.offer_id, receipt_id: @offer_redemption.receipt_id, shop_id: @offer_redemption.shop_id, user_id: @offer_redemption.user_id } }
    end

    assert_redirected_to offer_redemption_url(OfferRedemption.last)
  end

  test "should show offer_redemption" do
    get offer_redemption_url(@offer_redemption)
    assert_response :success
  end

  test "should get edit" do
    get edit_offer_redemption_url(@offer_redemption)
    assert_response :success
  end

  test "should update offer_redemption" do
    patch offer_redemption_url(@offer_redemption), params: { offer_redemption: { offer_id: @offer_redemption.offer_id, receipt_id: @offer_redemption.receipt_id, shop_id: @offer_redemption.shop_id, user_id: @offer_redemption.user_id } }
    assert_redirected_to offer_redemption_url(@offer_redemption)
  end

  test "should destroy offer_redemption" do
    assert_difference("OfferRedemption.count", -1) do
      delete offer_redemption_url(@offer_redemption)
    end

    assert_redirected_to offer_redemptions_url
  end
end
