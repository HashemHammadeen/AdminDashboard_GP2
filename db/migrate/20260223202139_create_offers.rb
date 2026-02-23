class CreateOffers < ActiveRecord::Migration[8.1]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :image_url
      t.string :reward_type
      t.jsonb :reward_value
      t.boolean :active
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
