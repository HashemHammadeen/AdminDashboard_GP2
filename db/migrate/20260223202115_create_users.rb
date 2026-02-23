class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :phone, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.text :password_hash, null: false
      t.string :gender, null: false
      t.string :profile_image_url
      t.references :tier, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
