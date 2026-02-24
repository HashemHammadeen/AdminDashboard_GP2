class Qr < ApplicationRecord
  self.table_name = "qr"
  belongs_to :user
  belongs_to :shop
end