class CreateMallAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :mall_admins, id: :uuid do |t|
      t.references :mall, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone, null: false, index: { unique: true }

      ## Devise fields - MUST be named encrypted_password
      t.string :email,              null: false, default: "", index: { unique: true }
      t.string :encrypted_password, null: false, default: "" # Change password_hash to this!

      t.string   :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end