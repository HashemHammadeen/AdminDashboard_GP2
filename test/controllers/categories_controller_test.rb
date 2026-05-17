require "test_helper"
require_relative "malls_controller_test"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @category = create_category(@mall)
    @mall_admin = create_mall_admin(@mall)
  end

  test "unauthenticated redirects to login" do
    get categories_url
    assert_redirected_to root_path
  end

  test "mall admin can list categories" do
    login_as_mall_admin(@mall_admin)
    get categories_url
    assert_response :success
  end

  test "mall admin can view a category" do
    login_as_mall_admin(@mall_admin)
    get category_url(@category)
    assert_response :success
  end

  test "mall admin can create a category" do
    login_as_mall_admin(@mall_admin)
    assert_difference "Category.count", 1 do
      post categories_url, params: {
        category: {
          mall_id: @mall.id,
          name: "New Cat #{SecureRandom.uuid}",
          description: "Desc",
          icon_url: "https://example.com/icon.png"
        }
      }
    end
    assert_redirected_to category_url(Category.order(created_at: :desc).first!)
  end

  test "mall admin can update a category" do
    login_as_mall_admin(@mall_admin)
    patch category_url(@category), params: { category: { description: "Updated desc" } }
    assert_redirected_to category_url(@category)
  end
end
