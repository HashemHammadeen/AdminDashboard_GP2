require "test_helper"

class MallTest < ActiveSupport::TestCase
  test "valid mall creation" do
    mall = Mall.new(name: "Test Mall", location: "Test Location")
    assert mall.save, "Mall should save with valid attributes"
  end

  test "name is required" do
    mall = Mall.new(location: "Test Location")
    refute mall.save
    assert mall.errors[:name].any?
  end

  test "location is required" do
    mall = Mall.new(name: "Test Mall #{SecureRandom.uuid}")
    refute mall.save
    assert mall.errors[:location].any?
  end

  test "has many shops" do
    mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    assert_respond_to mall, :shops
  end

  test "has many mall_admins" do
    mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    assert_respond_to mall, :mall_admins
  end
end
