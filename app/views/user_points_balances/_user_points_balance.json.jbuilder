json.extract! user_points_balance, :id, :user_id, :total_points, :lifetime_points, :created_at, :updated_at
json.url user_points_balance_url(user_points_balance, format: :json)
