class Receipt < ApplicationRecord
  self.primary_key = "receipt_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :amount, :Amount
  alias_attribute :receipt_currency, :Currency

  belongs_to :shop
  belongs_to :user
  has_one :offer_redemption, foreign_key: :redemption_ref
  has_one :stamp_transaction, foreign_key: :redemption_ref

  enum :status, { pending: "pending", approved: "approved", rejected: "rejected" }
end