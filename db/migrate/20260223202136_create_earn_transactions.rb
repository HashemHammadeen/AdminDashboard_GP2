class CreateEarnTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :earn_transactions, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :shop, type: :uuid, null: false, foreign_key: true
      t.decimal :purchase_amount, precision: 10, scale: 2
      t.integer :points_earned
      t.string :transaction_ref
      t.timestamps
    end
  end
end
