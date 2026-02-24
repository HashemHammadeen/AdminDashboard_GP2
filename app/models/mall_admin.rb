class MallAdmin < ApplicationRecord
  has_secure_password
  belongs_to :mall
end