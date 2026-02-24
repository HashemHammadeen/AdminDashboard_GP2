class StampTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :stamp
  belongs_to :receipt, foreign_key: :redemption_ref, optional: true
end