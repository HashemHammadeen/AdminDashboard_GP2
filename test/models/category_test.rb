require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
  end

  test "valid category creation" do
    cat = Category.new(
      mall: @mall,
      name: "Food",
      description: "Food shops",
      icon_url: "https://example.com/icon.png"
    )
    assert cat.save
  end

  test "name is required" do
    cat = Category.new(mall: @mall, description: "desc", icon_url: "https://example.com/icon.png")
    refute cat.save
    assert cat.errors[:name].any?
  end

  test "belongs to mall" do
    cat = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    assert_equal @mall, cat.mall
  end

  test "has many shops" do
    cat = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    assert_respond_to cat, :shops
  end
end
