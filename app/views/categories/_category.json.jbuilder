json.extract! category, :id, :category_name, :icon_url, :display_order, :description, :created_at, :updated_at
json.url category_url(category, format: :json)
