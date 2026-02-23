class CreateSystemConfigs < ActiveRecord::Migration[8.1]
  def change
    create_table :system_configs do |t|
      t.decimal :points_to_currency_ratio, precision: 10, scale: 4, default: 0.01
      t.decimal :earn_points_per_currency, precision: 10, scale: 2, default: 1.0
      t.integer :min_redemption_threshold, default: 100
      t.uuid :updated_by_admin_id
      t.timestamps
    end
  end
end
