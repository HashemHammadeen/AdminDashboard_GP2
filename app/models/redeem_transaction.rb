class RedeemTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  enum :status, { pending: "pending", verified: "verified", cancelled: "cancelled" }
end