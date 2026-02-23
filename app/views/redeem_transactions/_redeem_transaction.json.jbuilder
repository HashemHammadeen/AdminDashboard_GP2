json.extract! redeem_transaction, :id, :user_id, :shop_id, :points_used, :discount_value, :verification_code, :status, :completed_at, :created_at, :updated_at
json.url redeem_transaction_url(redeem_transaction, format: :json)
