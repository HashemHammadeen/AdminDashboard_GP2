class UserStampCard < ApplicationRecord
  # Specify composite primary key natively supported in Rails 7.1+
  self.primary_key = [:user_id, :stamp_id]
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end

  def updated_at
    created_at
  end

  attribute :stamps_counter, :big_integer

  belongs_to :user
  belongs_to :stamp
end