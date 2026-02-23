class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops, id: :uuid do |t|
      t.references :mall, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false, index: { unique: true }
      t.references :category, type: :uuid, null: false, foreign_key: true
      t.text :bio
      t.string :logo_url
      t.string :cover_image_url
      t.string :website_url
      t.jsonb :social_links
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end
