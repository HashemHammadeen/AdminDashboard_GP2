class Offer < ApplicationRecord
  self.primary_key = "offer_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :shop
  has_many :offer_redemptions

  attribute :points_required, :big_integer
end