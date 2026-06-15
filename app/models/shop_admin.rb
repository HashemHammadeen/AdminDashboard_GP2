class ShopAdmin < ApplicationRecord
  self.primary_key = "shop_admin_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  alias_attribute :password_digest, :password_hash
  alias_attribute :email, :Email
  has_secure_password
  prepend LegacyPasswordAuthenticatable

  enum :role, { staff: "Staff", admin: "Admin" }, default: :staff

  belongs_to :shop

  has_many :shop_admin_sessions, dependent: :destroy
  has_many :shop_admin_password_reset_requests, dependent: :destroy

  validates :email, :phone, :name, presence: true
  validates :email, :phone, uniqueness: true
  validates :role, presence: true, inclusion: { in: roles.keys }
end