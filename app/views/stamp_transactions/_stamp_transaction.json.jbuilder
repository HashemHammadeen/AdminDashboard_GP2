json.extract! stamp_transaction, :id, :user_id, :shop_id, :stamp_id, :transaction_type, :stamps_count, :receipt_id, :created_at, :updated_at
json.url stamp_transaction_url(stamp_transaction, format: :json)
