class User < ApplicationRecord
  self.primary_key = "user_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :password_digest, :password_hash
  has_secure_password # Uses password_hash column via alias
  belongs_to :tier
  has_one :user_points_balance, dependent: :destroy
  has_many :receipts
  has_many :earn_transactions
  has_many :redeem_transactions
  has_many :user_stamp_cards
  has_many :qrs

  validates :email, :phone, presence: true, uniqueness: true
end
