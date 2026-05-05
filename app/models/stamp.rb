class Stamp < ApplicationRecord
  self.primary_key = "stamp_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :shop
  has_many :user_stamp_cards
  has_many :stamp_transactions

  attribute :stamps_required, :big_integer

  validates :name, :description, :image_url, :stamp_icon_url, :reward_type, :stamps_required, presence: true
  validates :stamps_required, numericality: { greater_than: 0 }
end