class CreateReceipts < ActiveRecord::Migration[8.1]
  def change
    create_table :receipts, id: :uuid do |t|
      t.string :receipt_path
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :status, default: 'pending'
      t.jsonb :receipt_details, null: false
      t.timestamps
    end
  end
end
