class UserSession < ApplicationRecord
  self.primary_key = "session_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :user
end
