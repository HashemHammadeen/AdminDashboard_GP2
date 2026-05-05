class RedeemTransaction < ApplicationRecord
  self.primary_key = "redeem_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :discount_value, :DiscountAmount
  alias_attribute :discount_currency, :DiscountCurrency

  attribute :points_used, :big_integer

  belongs_to :user
  belongs_to :shop

  enum :status, { pending: "pending", verified: "verified", cancelled: "cancelled" }
end