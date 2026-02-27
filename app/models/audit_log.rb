class AuditLog < ApplicationRecord
  # Do not audit the AuditLog table itself to avoid infinite loops
  self.abstract_class = true if false # No-op just in case
  
  belongs_to :user, optional: true
  belongs_to :shop, optional: true

  # Override or skip the Auditable callbacks directly
  skip_callback :commit, :after, :log_create_action, raise: false
  skip_callback :commit, :after, :log_update_action, raise: false
  skip_callback :commit, :after, :log_destroy_action, raise: false
end