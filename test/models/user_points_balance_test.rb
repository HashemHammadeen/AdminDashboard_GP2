require "test_helper"

class UserPointsBalanceTest < ActiveSupport::TestCase
  def setup
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
  end

  test "valid user points balance creation" do
    balance = UserPointsBalance.new(user: @user, total_points: 500, lifetime_points: 1000)
    assert balance.save
  end

  test "belongs to user" do
    balance = UserPointsBalance.create!(user: @user, total_points: 0, lifetime_points: 0)
    assert_equal @user, balance.user
  end

  test "updated_at returns Time.current" do
    balance = UserPointsBalance.create!(user: @user, total_points: 100, lifetime_points: 100)
    assert_kind_of Time, balance.updated_at
  end
end
