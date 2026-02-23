json.extract! user, :id, :firstname, :lastname, :phone, :email, :password_hash, :gender, :profile_image_url, :tier_id, :created_at, :updated_at
json.url user_url(user, format: :json)
