class OfferRedemption < ApplicationRecord
  self.primary_key = "redemption_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :user
  belongs_to :offer
  belongs_to :shop

  belongs_to :redemption_qr, class_name: "Qr", foreign_key: :redemption_ref, optional: true
  
  attribute :points_received, :big_integer
  
  validates :user_id, :offer_id, :shop_id, presence: true
end