class RemoveUpdatedAtFromTasksElevenToFourteen < ActiveRecord::Migration[8.1]
  def change
    remove_column :malls, :updated_at, :datetime if column_exists?(:malls, :updated_at)
    remove_column :categories, :updated_at, :datetime if column_exists?(:categories, :updated_at)
    remove_column :tiers, :updated_at, :datetime if column_exists?(:tiers, :updated_at)
    remove_column :qrs, :updated_at, :datetime if column_exists?(:qrs, :updated_at)
    remove_column :offer_redemptions, :updated_at, :datetime if column_exists?(:offer_redemptions, :updated_at)
    remove_column :stamp_redemptions, :updated_at, :datetime if column_exists?(:stamp_redemptions, :updated_at)
    remove_column :user_stamp_cards, :updated_at, :datetime if column_exists?(:user_stamp_cards, :updated_at)
  end
end
