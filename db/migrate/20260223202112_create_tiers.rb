class CreateTiers < ActiveRecord::Migration[8.1]
  def change
    create_table :tiers, id: :uuid do |t|
      t.string :tier_name, null: false, index: { unique: true }
      t.integer :points_required, default: 0
      t.jsonb :benefits
      t.string :icon_url
      t.timestamps
    end
  end
end
