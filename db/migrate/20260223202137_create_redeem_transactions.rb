# db/migrate/20260223202137_create_redeem_transactions.rb
class CreateRedeemTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :redeem_transactions, id: :uuid do |t| # Add id: :uuid
      t.references :user, type: :uuid, null: false, foreign_key: true # Add type: :uuid
      t.references :shop, type: :uuid, null: false, foreign_key: true # Add type: :uuid
      t.integer :points_used, null: false
      t.decimal :discount_value, precision: 10, scale: 2, null: false
      t.string :verification_code, limit: 6, null: false
      t.string :status, default: 'pending'
      t.datetime :completed_at

      t.timestamps
    end
  end
end