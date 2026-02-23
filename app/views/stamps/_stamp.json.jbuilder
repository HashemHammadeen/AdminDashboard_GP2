json.extract! stamp, :id, :shop_id, :name, :description, :image_url, :stamp_icon_url, :stamps_required, :reward_type, :active, :start_date, :end_date, :created_at, :updated_at
json.url stamp_url(stamp, format: :json)
