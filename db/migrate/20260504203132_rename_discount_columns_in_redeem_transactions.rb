class RenameDiscountColumnsInRedeemTransactions < ActiveRecord::Migration[8.1]
  def change
    rename_column :redeem_transactions, :discount_value, :DiscountAmount
    rename_column :redeem_transactions, :discount_currency, :DiscountCurrency
  end
end
