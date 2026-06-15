class MallAdmin < ApplicationRecord
  self.primary_key = "mall_admin_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :password_digest, :password_hash
  has_secure_password
  prepend LegacyPasswordAuthenticatable

  belongs_to :mall

  has_many :mall_admin_sessions, dependent: :destroy
  has_many :mall_admin_password_reset_requests, dependent: :destroy
  has_many :system_configs, foreign_key: :updated_by_admin_id

  validates :email, :phone, :name, presence: true
  validates :email, :phone, uniqueness: true
end