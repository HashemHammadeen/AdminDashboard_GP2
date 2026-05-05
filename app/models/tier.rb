class Tier < ApplicationRecord
  self.primary_key = "tier_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  has_many :users

  attribute :points_required, :big_integer
  attribute :tier_order, :big_integer
  validates :name, presence: true, uniqueness: true
end