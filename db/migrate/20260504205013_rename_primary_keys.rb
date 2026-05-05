class RenamePrimaryKeys < ActiveRecord::Migration[8.1]
  def change
    rename_column :mall_admins, :id, :mall_admin_id if column_exists?(:mall_admins, :id)
    rename_column :shop_admins, :id, :shop_admin_id if column_exists?(:shop_admins, :id)
    rename_column :users, :id, :user_id if column_exists?(:users, :id)
    rename_column :stamp_transactions, :id, :stamp_tx_id if column_exists?(:stamp_transactions, :id)
    rename_column :earn_transactions, :id, :earn_id if column_exists?(:earn_transactions, :id)
    rename_column :stamps, :id, :stamp_id if column_exists?(:stamps, :id)
    rename_column :offers, :id, :offer_id if column_exists?(:offers, :id)
    rename_column :categories, :id, :category_id if column_exists?(:categories, :id)
    rename_column :malls, :id, :mall_id if column_exists?(:malls, :id)
    rename_column :tiers, :id, :tier_id if column_exists?(:tiers, :id)
    rename_column :qr_code, :id, :qr_id if column_exists?(:qr_code, :id)
    rename_column :audit_logs, :id, :log_id if column_exists?(:audit_logs, :id)
    rename_column :password_reset_requests, :id, :request_id if column_exists?(:password_reset_requests, :id)
    rename_column :mall_admin_password_reset_requests, :id, :request_id if column_exists?(:mall_admin_password_reset_requests, :id)
    rename_column :shop_admin_password_reset_requests, :id, :request_id if column_exists?(:shop_admin_password_reset_requests, :id)
    rename_column :user_sessions, :id, :session_id if column_exists?(:user_sessions, :id)
    rename_column :mall_admin_sessions, :id, :session_id if column_exists?(:mall_admin_sessions, :id)
    rename_column :shop_admin_sessions, :id, :session_id if column_exists?(:shop_admin_sessions, :id)
    
    # Missing from previous tasks
    rename_column :redeem_transactions, :id, :redeem_id if column_exists?(:redeem_transactions, :id)
    rename_column :receipts, :id, :receipt_id if column_exists?(:receipts, :id)
    rename_column :offer_redemptions, :id, :redemption_id if column_exists?(:offer_redemptions, :id)
    rename_column :stamp_redemptions, :id, :redemption_id if column_exists?(:stamp_redemptions, :id)

    # Preserve UUID defaults — rename_column can drop them in some PG setups
    {
      mall_admins: "mall_admin_id",
      shop_admins: "shop_admin_id",
      users: "user_id",
      stamp_transactions: "stamp_tx_id",
      earn_transactions: "earn_id",
      stamps: "stamp_id",
      offers: "offer_id",
      categories: "category_id",
      malls: "mall_id",
      tiers: "tier_id",
      qr_code: "qr_id",
      audit_logs: "log_id",
      password_reset_requests: "request_id",
      mall_admin_password_reset_requests: "request_id",
      shop_admin_password_reset_requests: "request_id",
      user_sessions: "session_id",
      mall_admin_sessions: "session_id",
      shop_admin_sessions: "session_id",
      redeem_transactions: "redeem_id",
      receipts: "receipt_id",
      offer_redemptions: "redemption_id",
      stamp_redemptions: "redemption_id",
    }.each do |table, col|
      execute "ALTER TABLE #{table} ALTER COLUMN #{col} SET DEFAULT gen_random_uuid()" if column_exists?(table, col)
    end
  end
end
