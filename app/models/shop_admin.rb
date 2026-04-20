class ShopAdmin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :shop

  def active_for_authentication?
    super && is_active
  end

  def inactive_message
    is_active ? super : :inactive
  end
end