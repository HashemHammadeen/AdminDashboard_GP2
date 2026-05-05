class DropExtraTimestampColumns < ActiveRecord::Migration[8.1]
  def change
    # Supabase has NO updated_at on these tables — drop from local DB
    tables_without_updated_at = %w[
      mall_admins shop_admins earn_transactions redeem_transactions receipts
      stamps offers shops stamp_transactions audit_logs users user_sessions
      mall_admin_sessions shop_admin_sessions malls categories tiers
      offer_redemptions stamp_redemptions user_stamp_cards shop_points_wallets
      user_points_balances
    ]

    tables_without_updated_at.each do |table|
      remove_column table, :updated_at if column_exists?(table, :updated_at)
    end

    # Supabase has NO created_at on these tables — drop from local DB
    tables_without_created_at = %w[
      qr_code user_points_balances shop_points_wallets password_reset_requests
      mall_admin_password_reset_requests shop_admin_password_reset_requests
      system_configs
    ]

    tables_without_created_at.each do |table|
      remove_column table, :created_at if column_exists?(table, :created_at)
    end
  end
end
