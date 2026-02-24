class Receipt < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_one :offer_redemption, foreign_key: :redemption_ref
  has_one :stamp_transaction, foreign_key: :redemption_ref

  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }
end