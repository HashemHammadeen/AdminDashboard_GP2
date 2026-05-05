class ShopAdminPasswordResetRequest < ApplicationRecord
  self.primary_key = "request_id"
  self.record_timestamps = false
  belongs_to :shop_admin
end
