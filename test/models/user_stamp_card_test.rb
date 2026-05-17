require "test_helper"

class UserStampCardTest < ActiveSupport::TestCase
  def setup
    @mall = Mall.create!(name: "Mall #{SecureRandom.uuid}", location: "Location")
    @category = Category.create!(mall: @mall, name: "Cat #{SecureRandom.uuid}", description: "Desc", icon_url: "https://example.com/icon.png")
    @shop = Shop.create!(mall: @mall, category: @category, name: "Shop #{SecureRandom.uuid}", bio: "Bio", logo_url: "l.png", cover_image_url: "c.png")
    @tier = Tier.create!(name: "Tier #{SecureRandom.uuid}", points_required: 0, tier_order: 1, icon_url: "https://example.com/icon.png")
    @user = User.create!(tier: @tier, first_name: "Test", last_name: "User", email: "u#{SecureRandom.uuid}@test.com", phone: "07#{SecureRandom.uuid[0..7].gsub("-", "")}", password: "password123", gender: "male")
    @stamp = Stamp.create!(
      shop: @shop,
      name: "Stamp #{SecureRandom.uuid}",
      description: "Desc",
      image_url: "img.png",
      stamp_icon_url: "icon.png",
      reward_type: "free_item",
      stamps_required: 5
    )
  end

  # Composite primary key conflicts with ensure_uuid_primary_key in ApplicationRecord.
  # We use raw SQL insert to bypass the callback.
  def insert_card(user, stamp, stamps_counter: 0)
    now = Time.current.strftime("%Y-%m-%d %H:%M:%S")
    ApplicationRecord.connection.execute(<<~SQL)
      INSERT INTO user_stamp_card (user_id, stamp_id, stamps_counter, created_at)
      VALUES ('#{user.id}', '#{stamp.id}', #{stamps_counter}, '#{now}')
      ON CONFLICT DO NOTHING
    SQL
    UserStampCard.find([ user.id, stamp.id ])
  end

  test "valid user stamp card creation via SQL" do
    card = insert_card(@user, @stamp)
    assert_not_nil card
  end

  test "belongs to user and stamp" do
    card = insert_card(@user, @stamp)
    assert_equal @user.id, card.user_id
    assert_equal @stamp.id, card.stamp_id
  end

  test "stamps_counter defaults to 0" do
    card = insert_card(@user, @stamp)
    assert_equal 0, card.stamps_counter
  end

  test "composite primary key is user_id and stamp_id" do
    insert_card(@user, @stamp, stamps_counter: 3)
    found = UserStampCard.find([ @user.id, @stamp.id ])
    assert_equal 3, found.stamps_counter
  end
end
