class UserStampCard < ApplicationRecord
  # Composite primary key (user_id, stamp_id) requires the 'composite_primary_keys' gem
  # or handling it as a join table without a standard ID.
  belongs_to :user
  belongs_to :stamp
end