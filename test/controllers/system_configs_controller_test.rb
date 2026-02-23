require "test_helper"

class SystemConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_config = system_configs(:one)
  end

  test "should get index" do
    get system_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_system_config_url
    assert_response :success
  end

  test "should create system_config" do
    assert_difference("SystemConfig.count") do
      post system_configs_url, params: { system_config: { earn_points_per_currency: @system_config.earn_points_per_currency, min_redemption_threshold: @system_config.min_redemption_threshold, points_to_currency_ratio: @system_config.points_to_currency_ratio } }
    end

    assert_redirected_to system_config_url(SystemConfig.last)
  end

  test "should show system_config" do
    get system_config_url(@system_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_config_url(@system_config)
    assert_response :success
  end

  test "should update system_config" do
    patch system_config_url(@system_config), params: { system_config: { earn_points_per_currency: @system_config.earn_points_per_currency, min_redemption_threshold: @system_config.min_redemption_threshold, points_to_currency_ratio: @system_config.points_to_currency_ratio } }
    assert_redirected_to system_config_url(@system_config)
  end

  test "should destroy system_config" do
    assert_difference("SystemConfig.count", -1) do
      delete system_config_url(@system_config)
    end

    assert_redirected_to system_configs_url
  end
end
