class Category < ApplicationRecord
  belongs_to :mall
  has_many :shops
  validates :name, presence: true
end