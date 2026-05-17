require "test_helper"

class MallAdminTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
  end

  test "valid mall admin creation with password" do
    admin = MallAdmin.new(
      mall: @mall,
      name: "Admin",
      email: "admin#{SecureRandom.uuid}@test.com",
      phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
      password: "password123"
    )
    assert admin.save
  end

  test "email is required" do
    admin = MallAdmin.new(mall: @mall, name: "Admin", phone: "0799999999", password: "password123")
    refute admin.save
    assert admin.errors[:email].any?
  end

  test "phone is required" do
    admin = MallAdmin.new(mall: @mall, name: "Admin", email: "a#{SecureRandom.uuid}@test.com", password: "password123")
    refute admin.save
    assert admin.errors[:phone].any?
  end

  test "email must be unique" do
    email = "unique#{SecureRandom.uuid}@test.com"
    MallAdmin.create!(mall: @mall, name: "A1", email: email, phone: "071#{SecureRandom.uuid[0..6].gsub("-", "")}", password: "password123")
    admin2 = MallAdmin.new(mall: @mall, name: "A2", email: email, phone: "072#{SecureRandom.uuid[0..6].gsub("-", "")}", password: "password123")
    refute admin2.save
    assert admin2.errors[:email].any?
  end

  test "has_secure_password authentication" do
    admin = MallAdmin.create!(
      mall: @mall,
      name: "Auth Admin",
      email: "auth#{SecureRandom.uuid}@test.com",
      phone: "073#{SecureRandom.uuid[0..6].gsub("-", "")}",
      password: "securepass"
    )
    assert admin.authenticate("securepass")
    assert_not admin.authenticate("wrongpass")
  end

  test "belongs to mall" do
    admin = MallAdmin.create!(mall: @mall, name: "A", email: "e#{SecureRandom.uuid}@test.com", phone: "074#{SecureRandom.uuid[0..6].gsub("-", "")}", password: "password123")
    assert_equal @mall, admin.mall
  end
end
