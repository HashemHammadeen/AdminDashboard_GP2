class UserStampCard < ApplicationRecord
  # Specify composite primary key natively supported in Rails 7.1+
  self.primary_key = [:user_id, :stamp_id]

  belongs_to :user
  belongs_to :stamp
end