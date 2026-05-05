class EarnTransaction < ApplicationRecord
  self.primary_key = "earn_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :purchase_amount, :PurchaseAmount
  alias_attribute :purchase_currency, :PurchaseCurrency

  attribute :points_earned, :big_integer

  belongs_to :user
  belongs_to :shop
end