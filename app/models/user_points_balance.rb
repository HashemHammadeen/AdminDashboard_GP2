class UserPointsBalance < ApplicationRecord
  self.primary_key = "user_points_balance_id"
  self.record_timestamps = false

  def updated_at
    Time.current
  end

  attribute :total_points, :big_integer
  attribute :lifetime_points, :big_integer

  belongs_to :user
end