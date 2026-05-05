class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Auditable

  before_create :ensure_uuid_primary_key

  private

  def ensure_uuid_primary_key
    pk = self.class.primary_key
    if pk && self[pk].blank?
      self[pk] = SecureRandom.uuid
    end
  end
end
