require "test_helper"

class ShopAdminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop_admin = shop_admins(:one)
  end

  test "should get index" do
    get shop_admins_url
    assert_response :success
  end

  test "should get new" do
    get new_shop_admin_url
    assert_response :success
  end

  test "should create shop_admin" do
    assert_difference("ShopAdmin.count") do
      post shop_admins_url, params: { shop_admin: { email: @shop_admin.email, is_active: @shop_admin.is_active, name: @shop_admin.name, password_hash: @shop_admin.password_hash, phone: @shop_admin.phone, shop_id: @shop_admin.shop_id } }
    end

    assert_redirected_to shop_admin_url(ShopAdmin.last)
  end

  test "should show shop_admin" do
    get shop_admin_url(@shop_admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_shop_admin_url(@shop_admin)
    assert_response :success
  end

  test "should update shop_admin" do
    patch shop_admin_url(@shop_admin), params: { shop_admin: { email: @shop_admin.email, is_active: @shop_admin.is_active, name: @shop_admin.name, password_hash: @shop_admin.password_hash, phone: @shop_admin.phone, shop_id: @shop_admin.shop_id } }
    assert_redirected_to shop_admin_url(@shop_admin)
  end

  test "should destroy shop_admin" do
    assert_difference("ShopAdmin.count", -1) do
      delete shop_admin_url(@shop_admin)
    end

    assert_redirected_to shop_admins_url
  end
end
