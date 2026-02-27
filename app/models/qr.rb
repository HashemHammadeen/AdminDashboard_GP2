class Qr < ApplicationRecord
  self.table_name = "qrs"
  belongs_to :user
  belongs_to :shop
end