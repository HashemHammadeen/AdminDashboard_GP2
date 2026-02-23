class CreateStamps < ActiveRecord::Migration[8.1]
  def change
    create_table :stamps, id: :uuid do |t|
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :image_url
      t.string :stamp_icon_url
      t.integer :stamps_required, null: false
      t.string :reward_type, null: false
      t.boolean :active, default: true
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
