class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Auditable

  # Supabase generates UUIDs via triggers, but Rails can't see those defaults.
  # Generate UUIDs in Ruby so we never send NULL for the primary key.
  before_create :ensure_uuid_primary_key

  private

  def ensure_uuid_primary_key
    pk = self.class.primary_key
    return unless pk.present?

    col = self.class.columns_hash[pk]
    return unless col&.sql_type&.include?("uuid")

    self[pk] ||= SecureRandom.uuid
  end
end
