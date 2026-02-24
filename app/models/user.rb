class User < ApplicationRecord
  has_secure_password # Assumes you are using bcrypt
  belongs_to :tier
  has_one :user_points_balance, dependent: :destroy
  has_many :receipts
  has_many :earn_transactions
  has_many :redeem_transactions
  has_many :user_stamp_cards
  has_many :qrs

  validates :email, :phone, presence: true, uniqueness: true
end
