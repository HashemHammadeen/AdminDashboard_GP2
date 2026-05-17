require "test_helper"
require_relative "malls_controller_test"

class StampsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @shop_admin = create_shop_admin(@shop)
    @stamp = Stamp.create!(
      shop: @shop,
      name: "Stamp #{SecureRandom.uuid}",
      description: "Buy 10 get 1 free",
      image_url: "img.png",
      stamp_icon_url: "icon.png",
      reward_type: "free_item",
      stamps_required: 10
    )
  end

  test "unauthenticated redirects to login" do
    get stamps_url
    assert_redirected_to root_path
  end

  test "shop admin can list stamps" do
    login_as_shop_admin(@shop_admin)
    get stamps_url
    assert_response :success
  end

  test "shop admin can view a stamp" do
    login_as_shop_admin(@shop_admin)
    get stamp_url(@stamp)
    assert_response :success
  end

  test "shop admin can create a stamp" do
    login_as_shop_admin(@shop_admin)
    assert_difference "Stamp.count", 1 do
      post stamps_url, params: {
        stamp: {
          shop_id: @shop.id,
          name: "New Stamp #{SecureRandom.uuid}",
          description: "Desc",
          image_url: "img.png",
          stamp_icon_url: "icon.png",
          reward_type: "free_item",
          stamps_required: 5
        }
      }
    end
    assert_redirected_to stamp_url(Stamp.order(created_at: :desc).first!)
  end
end
