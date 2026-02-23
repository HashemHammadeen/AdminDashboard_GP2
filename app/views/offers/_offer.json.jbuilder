json.extract! offer, :id, :shop_id, :name, :description, :image_url, :reward_type, :reward_value, :active, :start_date, :end_date, :created_at, :updated_at
json.url offer_url(offer, format: :json)
