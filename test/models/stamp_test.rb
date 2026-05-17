require "test_helper"

class StampTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
  end

  def valid_stamp_attrs
    {
      shop: @shop,
      name: "Coffee Card #{SecureRandom.uuid}",
      description: "Buy 10 get 1 free",
      image_url: "https://example.com/stamp.png",
      stamp_icon_url: "https://example.com/icon.png",
      reward_type: "free_item",
      stamps_required: 10
    }
  end

  test "valid stamp creation" do
    stamp = Stamp.new(valid_stamp_attrs)
    assert stamp.save
  end

  test "stamps_required must be greater than 0" do
    stamp = Stamp.new(valid_stamp_attrs.merge(stamps_required: 0))
    refute stamp.save
    assert stamp.errors[:stamps_required].any?
  end

  test "negative stamps_required is invalid" do
    stamp = Stamp.new(valid_stamp_attrs.merge(stamps_required: -1))
    refute stamp.save
    assert stamp.errors[:stamps_required].any?
  end

  test "name is required" do
    stamp = Stamp.new(valid_stamp_attrs.merge(name: nil))
    refute stamp.save
    assert stamp.errors[:name].any?
  end

  test "description is required" do
    stamp = Stamp.new(valid_stamp_attrs.merge(description: nil))
    refute stamp.save
    assert stamp.errors[:description].any?
  end

  test "belongs to shop" do
    stamp = Stamp.create!(valid_stamp_attrs)
    assert_equal @shop, stamp.shop
  end
end
