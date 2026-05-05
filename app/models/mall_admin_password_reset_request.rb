class MallAdminPasswordResetRequest < ApplicationRecord
  self.primary_key = "request_id"
  self.record_timestamps = false
  belongs_to :mall_admin
end
