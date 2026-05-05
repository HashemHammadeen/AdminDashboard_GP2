class StampRedemption < ApplicationRecord
  self.primary_key = "redemption_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :stamp
  belongs_to :user
  belongs_to :shop
  belongs_to :qr, foreign_key: :redemption_ref, optional: true
end
