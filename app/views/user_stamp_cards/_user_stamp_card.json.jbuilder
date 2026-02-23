json.extract! user_stamp_card, :id, :user_id, :stamp_id, :stamps_counter, :is_completed, :last_transaction, :created_at, :updated_at
json.url user_stamp_card_url(user_stamp_card, format: :json)
