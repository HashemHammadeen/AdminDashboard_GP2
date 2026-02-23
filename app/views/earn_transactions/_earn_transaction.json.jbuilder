json.extract! earn_transaction, :id, :user_id, :shop_id, :purchase_amount, :points_earned, :transaction_ref, :created_at, :updated_at
json.url earn_transaction_url(earn_transaction, format: :json)
