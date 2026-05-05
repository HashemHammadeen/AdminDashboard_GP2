class AlignEarnTransactionColumns < ActiveRecord::Migration[8.1]
  def change
    rename_column :earn_transactions, :purchase_amount, :PurchaseAmount
    rename_column :earn_transactions, :purchase_currency, :PurchaseCurrency
  end
end
