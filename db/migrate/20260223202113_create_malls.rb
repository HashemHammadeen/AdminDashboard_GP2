class CreateMalls < ActiveRecord::Migration[8.1]
  def change
    create_table :malls, id: :uuid do |t|
      t.string :mall_name, null: false, index: { unique: true }
      t.string :location
      t.string :logo_url
      t.string :cover_image_url
      t.timestamps
    end
  end
end
