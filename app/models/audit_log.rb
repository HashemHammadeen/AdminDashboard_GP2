class AuditLog < ApplicationRecord
  self.primary_key = "log_id"
  self.record_timestamps = true
  def self.timestamp_attributes_for_update
    []
  end
  # Do not audit the AuditLog table itself to avoid infinite loops
  self.abstract_class = true if false # No-op just in case

  attribute :points, :big_integer

  belongs_to :user, optional: true
  belongs_to :shop, optional: true
  belongs_to :mall_admin, optional: true
  belongs_to :shop_admin, optional: true

  # Override or skip the Auditable callbacks directly
  skip_callback :commit, :after, :log_create_action, raise: false
  skip_callback :commit, :after, :log_update_action, raise: false
  skip_callback :commit, :after, :log_destroy_action, raise: false
end