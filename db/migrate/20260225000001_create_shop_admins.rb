class CreateShopAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :shop_admins, id: :uuid do |t|
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone, null: false, index: { unique: true }
      t.boolean :is_active, default: true
      ## Devise fields
      t.string :email,              null: false, default: "", index: { unique: true }
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end