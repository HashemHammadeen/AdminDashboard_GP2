class Stamp < ApplicationRecord
  belongs_to :shop
  has_many :user_stamp_cards
  has_many :stamp_transactions

  validates :name, :description, :image_url, :stamp_icon_url, :reward_type, :stamps_required, presence: true
  validates :stamps_required, numericality: { greater_than: 0 }
end