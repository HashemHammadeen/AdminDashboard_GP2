json.extract! shop_admin, :id, :shop_id, :name, :email, :phone, :password_hash, :is_active, :created_at, :updated_at
json.url shop_admin_url(shop_admin, format: :json)
