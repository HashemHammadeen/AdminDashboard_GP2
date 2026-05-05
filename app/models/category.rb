class Category < ApplicationRecord
  self.primary_key = "category_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  belongs_to :mall
  has_many :shops
  validates :name, presence: true
end