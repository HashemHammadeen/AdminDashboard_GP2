class AlignSchemaTasksFourToNine < ActiveRecord::Migration[8.1]
  def change
    # Task 4: Receipt
    rename_column :receipts, :amount, :Amount
    rename_column :receipts, :receipt_currency, :Currency

    # Task 7: SystemConfig
    remove_column :system_configs, :id, :integer
    add_column :system_configs, :config_id, :uuid, default: -> { "gen_random_uuid()" }, null: false, primary_key: true

    # Task 8: OfferRedemption
    remove_foreign_key :offer_redemptions, :receipts
    rename_column :offer_redemptions, :receipt_id, :redemption_ref

    # Task 9: StampRedemption
    remove_foreign_key :stamp_redemptions, column: :qr_id
    remove_index :stamp_redemptions, :qr_id, unique: true if index_exists?(:stamp_redemptions, :qr_id)
    rename_column :stamp_redemptions, :qr_id, :redemption_ref
    change_column_null :stamp_redemptions, :redemption_ref, true
    add_index :stamp_redemptions, :redemption_ref
  end
end
