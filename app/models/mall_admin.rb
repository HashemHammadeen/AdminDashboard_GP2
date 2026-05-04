class MallAdmin < ApplicationRecord
  alias_attribute :password_digest, :password_hash
  has_secure_password

  belongs_to :mall

  has_many :mall_admin_sessions, dependent: :destroy
  has_many :mall_admin_password_reset_requests, dependent: :destroy
  has_many :system_configs, foreign_key: :updated_by_admin_id

  validates :email, :phone, :name, presence: true
  validates :email, :phone, uniqueness: true
end