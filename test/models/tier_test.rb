require "test_helper"

class TierTest < ActiveSupport::TestCase
  test "valid tier creation" do
    tier = Tier.new(
      name: "Gold #{SecureRandom.uuid}",
      points_required: 500,
      tier_order: 2,
      icon_url: "https://example.com/gold.png"
    )
    assert tier.save
  end

  test "name is required" do
    tier = Tier.new(points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    refute tier.save
    assert tier.errors[:name].any?
  end

  test "name must be unique" do
    name = "Unique Tier #{SecureRandom.uuid}"
    Tier.create!(name: name, points_required: 0, tier_order: 10, icon_url: "https://example.com/icon.png")
    tier2 = Tier.new(name: name, points_required: 100, tier_order: 11, icon_url: "https://example.com/icon.png")
    refute tier2.save
    assert tier2.errors[:name].any?
  end

  test "has many users" do
    tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 99, icon_url: "https://example.com/icon.png")
    assert_respond_to tier, :users
  end
end
