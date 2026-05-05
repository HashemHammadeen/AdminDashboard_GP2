class StampTransaction < ApplicationRecord
  self.primary_key = "stamp_tx_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  # Disable Rails STI so the `type` column is treated as a plain string
  self.inheritance_column = :_type_disabled

  attribute :stamps_count, :big_integer

  belongs_to :user
  belongs_to :shop
  belongs_to :stamp_program, class_name: "Stamp", foreign_key: :stamp_program_id
  alias_method :stamp, :stamp_program
  # redemption_ref is a uuid referencing qrs.id (optional)
  belongs_to :qr, foreign_key: :redemption_ref, optional: true
end