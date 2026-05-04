class StampTransaction < ApplicationRecord
  # Disable Rails STI so the `type` column is treated as a plain string
  self.inheritance_column = :_type_disabled

  belongs_to :user
  belongs_to :shop
  belongs_to :stamp_program, class_name: "Stamp", foreign_key: :stamp_program_id
  # redemption_ref is a uuid referencing qrs.id (optional)
  belongs_to :qr, foreign_key: :redemption_ref, optional: true
end