require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @tier = Tier.create!(
      name: "Bronze #{SecureRandom.uuid}",
      points_required: 0,
      tier_order: 1,
      icon_url: "https://example.com/icon.png"
    )
  end

  test "valid user creation with has_secure_password" do
    user = User.new(
      tier: @tier,
      first_name: "John",
      last_name: "Doe",
      email: "john#{SecureRandom.uuid}@test.com",
      phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}",
      password: "password123",
      gender: "male"
    )
    assert user.save
    assert user.authenticate("password123")
  end

  test "email uniqueness" do
    email = "dup#{SecureRandom.uuid}@test.com"
    User.create!(tier: @tier, first_name: "Jane", last_name: "Doe", email: email, phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "female")
    user2 = User.new(tier: @tier, first_name: "Bob", last_name: "Smith", email: email, phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
    refute user2.save
    assert user2.errors[:email].any?
  end

  test "phone uniqueness" do
    phone = "07#{SecureRandom.uuid[0..7].gsub("-", "")}"
    User.create!(tier: @tier, first_name: "A", last_name: "B", email: "a#{SecureRandom.uuid}@test.com", phone: phone, password: "password123", gender: "male")
    user2 = User.new(tier: @tier, first_name: "C", last_name: "D", email: "c#{SecureRandom.uuid}@test.com", phone: phone, password: "password123", gender: "female")
    refute user2.save
    assert user2.errors[:phone].any?
  end

  test "required fields" do
    user = User.new
    refute user.save
    assert user.errors[:email].any?
    assert user.errors[:phone].any?
  end

  test "belongs to tier" do
    user = User.create!(tier: @tier, first_name: "T", last_name: "U", email: "t#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
    assert_equal @tier, user.tier
  end

  test "wrong password does not authenticate" do
    user = User.create!(tier: @tier, first_name: "X", last_name: "Y", email: "x#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "correct", gender: "male")
    assert_not user.authenticate("wrong")
  end
end
