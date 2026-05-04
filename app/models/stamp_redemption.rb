class StampRedemption < ApplicationRecord
  belongs_to :stamp
  belongs_to :user
  belongs_to :shop
  belongs_to :qr, foreign_key: :qr_id
end
