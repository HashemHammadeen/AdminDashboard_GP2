class Shop < ApplicationRecord
  belongs_to :mall
  belongs_to :category
  has_many :shop_admins
  has_many :offers
  has_many :stamps
  has_many :receipts
  has_many :earn_transactions
  has_many :redeem_transactions

  validates :name, presence: true, uniqueness: true
end