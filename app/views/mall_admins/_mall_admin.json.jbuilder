json.extract! mall_admin, :id, :mall_id, :name, :email, :phone, :password_hash, :created_at, :updated_at
json.url mall_admin_url(mall_admin, format: :json)
