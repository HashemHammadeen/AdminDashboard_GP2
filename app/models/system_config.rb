class SystemConfig < ApplicationRecord
  self.primary_key = "config_id"
  self.record_timestamps = false
  
  attribute :min_redemption_threshold, :big_integer
  
  belongs_to :updated_by_admin, class_name: "MallAdmin", foreign_key: "updated_by_admin_id"
end