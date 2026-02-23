require "test_helper"

class MallAdminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mall_admin = mall_admins(:one)
  end

  test "should get index" do
    get mall_admins_url
    assert_response :success
  end

  test "should get new" do
    get new_mall_admin_url
    assert_response :success
  end

  test "should create mall_admin" do
    assert_difference("MallAdmin.count") do
      post mall_admins_url, params: { mall_admin: { email: @mall_admin.email, mall_id: @mall_admin.mall_id, name: @mall_admin.name, password_hash: @mall_admin.password_hash, phone: @mall_admin.phone } }
    end

    assert_redirected_to mall_admin_url(MallAdmin.last)
  end

  test "should show mall_admin" do
    get mall_admin_url(@mall_admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_mall_admin_url(@mall_admin)
    assert_response :success
  end

  test "should update mall_admin" do
    patch mall_admin_url(@mall_admin), params: { mall_admin: { email: @mall_admin.email, mall_id: @mall_admin.mall_id, name: @mall_admin.name, password_hash: @mall_admin.password_hash, phone: @mall_admin.phone } }
    assert_redirected_to mall_admin_url(@mall_admin)
  end

  test "should destroy mall_admin" do
    assert_difference("MallAdmin.count", -1) do
      delete mall_admin_url(@mall_admin)
    end

    assert_redirected_to mall_admins_url
  end
end
