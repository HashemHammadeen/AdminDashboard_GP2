class CreateMallAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :mall_admins, id: :uuid do |t| # Add id: :uuid
      t.references :mall, type: :uuid, null: false, foreign_key: true # Add type: :uuid
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone, null: false, index: { unique: true }
      t.text :password_hash, null: false
      t.timestamps
    end
  end
end
