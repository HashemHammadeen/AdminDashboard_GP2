class Qr < ApplicationRecord
  self.primary_key = "qr_id"
  self.table_name = "qr_code"
  self.record_timestamps = false
  
  def created_at
    Time.current
  end
  
  def updated_at
    Time.current
  end

  belongs_to :user, optional: true
  belongs_to :shop, optional: true
end