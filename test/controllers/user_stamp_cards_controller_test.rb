require "test_helper"
require_relative "malls_controller_test"

class UserStampCardsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @shop = create_shop(@mall, @category)
    @tier = create_tier
    @user = create_user(@tier)
    @shop_admin = create_shop_admin(@shop)
    @stamp = Stamp.create!(
      shop: @shop, name: "Stamp #{SecureRandom.uuid}", description: "Desc",
      image_url: "img.png", stamp_icon_url: "icon.png", reward_type: "free_item", stamps_required: 5
    )
    @card = UserStampCard.create!(user: @user, stamp: @stamp, stamps_counter: 0)
  end

  test "unauthenticated redirects to login" do
    get user_stamp_cards_url
    assert_redirected_to root_path
  end

  test "shop admin can list user stamp cards" do
    login_as_shop_admin(@shop_admin)
    get user_stamp_cards_url
    assert_response :success
  end

  test "shop admin can view a user stamp card" do
    login_as_shop_admin(@shop_admin)
    get user_stamp_card_url(@card)
    assert_response :success
  end

  test "shop admin can create a user stamp card" do
    login_as_shop_admin(@shop_admin)
    new_user = create_user(@tier)
    assert_difference "UserStampCard.count", 1 do
      post user_stamp_cards_url, params: {
        user_stamp_card: {
          user_id: new_user.id,
          stamp_id: @stamp.id,
          stamps_counter: 0
        }
      }
    end
  end
end
