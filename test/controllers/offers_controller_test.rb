require "test_helper"
require_relative "malls_controller_test"

class OffersControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @mall_admin = create_mall_admin(@mall)
    @shop_admin = create_shop_admin(@shop)
    @offer = Offer.create!(shop: @shop, name: "Offer #{SecureRandom.uuid}", description: "Desc", image_url: "img.png", reward_type: "discount")
  end

  test "unauthenticated redirects to login" do
    get offers_url
    assert_redirected_to root_path
  end

  test "shop admin can list offers" do
    login_as_shop_admin(@shop_admin)
    get offers_url
    assert_response :success
  end

  test "shop admin can view an offer" do
    login_as_shop_admin(@shop_admin)
    get offer_url(@offer)
    assert_response :success
  end

  test "shop admin can create an offer" do
    login_as_shop_admin(@shop_admin)
    assert_difference "Offer.count", 1 do
      post offers_url, params: {
        offer: {
          shop_id: @shop.id,
          name: "New Offer #{SecureRandom.uuid}",
          description: "Desc",
          image_url: "img.png",
          reward_type: "free_item",
          is_active: true
        }
      }
    end
    assert_redirected_to offer_url(Offer.order(created_at: :desc).first!)
  end

  test "mall admin can also list offers" do
    login_as_mall_admin(@mall_admin)
    get offers_url
    assert_response :success
  end
end
