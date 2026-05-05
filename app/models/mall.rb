class Mall < ApplicationRecord
  self.primary_key = "mall_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  validates :name, presence: true
  validates :location, presence: true
  has_many :shops
  has_many :mall_admins
end