class Mall < ApplicationRecord
  validates :mall_name, presence: true
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9][a-z0-9-]*[a-z0-9]\z/, message: "only allows lowercase letters, numbers, and dashes" }
  validates :location, presence: true
  has_many :shops
  has_many :mall_admins
end