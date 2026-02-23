json.extract! receipt, :id, :receipt_path, :shop_id, :user_id, :amount, :status, :receipt_details, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
