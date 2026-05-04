class UserPointsBalance < ApplicationRecord
  self.primary_key = "user_points_balance_id"

  belongs_to :user
end