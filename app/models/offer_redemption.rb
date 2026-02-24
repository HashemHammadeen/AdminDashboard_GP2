class OfferRedemption < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  belongs_to :shop
  belongs_to :receipt, optional: true
  validates :user_id, :offer_id, :shop_id, presence: true
end
