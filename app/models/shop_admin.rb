class ShopAdmin < ApplicationRecord
  alias_attribute :password_digest, :password_hash
  has_secure_password

  belongs_to :shop

  has_many :shop_admin_sessions, dependent: :destroy
  has_many :shop_admin_password_reset_requests, dependent: :destroy

  validates :email, :phone, :name, presence: true
  validates :email, :phone, uniqueness: true
end