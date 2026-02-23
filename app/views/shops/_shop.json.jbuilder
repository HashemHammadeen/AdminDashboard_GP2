json.extract! shop, :id, :mall_id, :name, :category_id, :logo_url, :cover_image_url, :bio, :website_url, :social_links, :is_active, :created_at, :updated_at
json.url shop_url(shop, format: :json)
