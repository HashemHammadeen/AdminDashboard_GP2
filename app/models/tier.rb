class Tier < ApplicationRecord
  has_many :users
  validates :tier_name, presence: true, uniqueness: true
end