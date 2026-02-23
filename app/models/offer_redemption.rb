class OfferRedemption < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  belongs_to :shop
  belongs_to :receipt
end
