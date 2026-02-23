class CreateStampTransactions < ActiveRecord::Migration[8.1]
  def change
    # 1. Added id: :uuid
    create_table :stamp_transactions, id: :uuid do |t|
      # 2. Added type: :uuid to all references
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.references :stamp, type: :uuid, null: false, foreign_key: true

      # 3. Added comments for clarity
      t.string :transaction_type, null: false, comment: "Must be 'collect' or 'redeem'"
      t.integer :stamps_count, null: false, default: 1

      # 4. Changed null: false to null: true for optional receipts
      t.references :receipt, type: :uuid, null: true, foreign_key: true

      t.timestamps
    end
  end
end