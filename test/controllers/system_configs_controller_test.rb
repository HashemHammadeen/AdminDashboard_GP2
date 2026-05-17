require "test_helper"
require_relative "malls_controller_test"

class SystemConfigsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
    @config = SystemConfig.create!(
      mall_id: @mall.id,
      earn_points_per_currency: 1.0,
      points_to_currency_ratio: 0.01,
      min_redemption_threshold: 100,
      updated_by_admin_id: @mall_admin.id,
      updated_at: Time.current
    )
  end

  test "unauthenticated redirects to login" do
    get system_configs_url
    assert_redirected_to root_path
  end

  test "mall admin can list system configs" do
    login_as_mall_admin(@mall_admin)
    get system_configs_url
    assert_response :success
  end

  test "mall admin can view a system config" do
    login_as_mall_admin(@mall_admin)
    get system_config_url(@config)
    assert_response :success
  end

  test "mall admin can edit system config" do
    login_as_mall_admin(@mall_admin)
    get edit_system_config_url(@config)
    assert_response :success
  end

  test "mall admin can update system config" do
    login_as_mall_admin(@mall_admin)
    patch system_config_url(@config), params: {
      system_config: {
        earn_points_per_currency: 2.0,
        points_to_currency_ratio: 0.02,
        min_redemption_threshold: 200,
        updated_by_admin_id: @mall_admin.id
      }
    }
    assert_redirected_to system_config_url(@config)
  end
end
