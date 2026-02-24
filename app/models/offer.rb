class Offer < ApplicationRecord
  belongs_to :shop
  has_many :offer_redemptions
end