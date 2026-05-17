require "test_helper"

class SystemConfigTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @admin = MallAdmin.create!(
      mall: @mall,
      name: "Admin",
      email: "a#{SecureRandom.uuid}@test.com",
      phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
      password: "password123"
    )
  end

  test "valid system config creation" do
    # record_timestamps = false so we must provide updated_at manually
    config = SystemConfig.new(
      mall_id: @mall.id,
      earn_points_per_currency: 1.0,
      points_to_currency_ratio: 0.01,
      min_redemption_threshold: 100,
      updated_by_admin_id: @admin.id,
      updated_at: Time.current
    )
    assert config.save
  end

  test "belongs to updated_by_admin" do
    config = SystemConfig.create!(
      mall_id: @mall.id,
      earn_points_per_currency: 1.0,
      points_to_currency_ratio: 0.01,
      min_redemption_threshold: 100,
      updated_by_admin_id: @admin.id,
      updated_at: Time.current
    )
    assert_equal @admin, config.updated_by_admin
  end
end
