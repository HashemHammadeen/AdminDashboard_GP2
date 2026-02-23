json.extract! qr, :id, :user_id, :shop_id, :qr_code_data, :expires_at, :created_at, :updated_at
json.url qr_url(qr, format: :json)
