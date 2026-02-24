class Mall < ApplicationRecord
  has_many :shops
  has_many :mall_admins
end