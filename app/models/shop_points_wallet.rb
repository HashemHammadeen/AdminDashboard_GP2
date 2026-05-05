class ShopPointsWallet < ApplicationRecord
  self.primary_key = "shop_id"
  self.record_timestamps = false

  attribute :points_received, :big_integer

  belongs_to :shop
end
