require "test_helper"

class ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get shops_url
    assert_response :success
  end

  test "should get new" do
    get new_shop_url
    assert_response :success
  end

  test "should create shop" do
    assert_difference("Shop.count") do
      post shops_url, params: { shop: { bio: @shop.bio, category_id: @shop.category_id, cover_image_url: @shop.cover_image_url, is_active: @shop.is_active, logo_url: @shop.logo_url, mall_id: @shop.mall_id, name: @shop.name, social_links: @shop.social_links, website_url: @shop.website_url } }
    end

    assert_redirected_to shop_url(Shop.last)
  end

  test "should show shop" do
    get shop_url(@shop)
    assert_response :success
  end

  test "should get edit" do
    get edit_shop_url(@shop)
    assert_response :success
  end

  test "should update shop" do
    patch shop_url(@shop), params: { shop: { bio: @shop.bio, category_id: @shop.category_id, cover_image_url: @shop.cover_image_url, is_active: @shop.is_active, logo_url: @shop.logo_url, mall_id: @shop.mall_id, name: @shop.name, social_links: @shop.social_links, website_url: @shop.website_url } }
    assert_redirected_to shop_url(@shop)
  end

  test "should destroy shop" do
    assert_difference("Shop.count", -1) do
      delete shop_url(@shop)
    end

    assert_redirected_to shops_url
  end
end
