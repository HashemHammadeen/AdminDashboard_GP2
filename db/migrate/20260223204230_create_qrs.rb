class CreateQrs < ActiveRecord::Migration[8.1]
  def change
    create_table :qrs, id: :uuid do |t| # Added id: :uuid
      t.references :user, type: :uuid, null: false, foreign_key: true # Added type: :uuid
      t.references :shop, type: :uuid, null: false, foreign_key: true # Added type: :uuid
      t.text :qr_code_data
      t.datetime :expires_at

      t.timestamps
    end
  end
end