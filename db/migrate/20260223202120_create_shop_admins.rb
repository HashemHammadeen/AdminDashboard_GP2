class CreateShopAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :shop_admins, id: :uuid do |t| # Add id: :uuid
      t.references :shop, type: :uuid, null: false, foreign_key: true # Add type: :uuid
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone, null: false, index: { unique: true }
      t.text :password_hash, null: false
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end