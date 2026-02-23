class UserStampCard < ApplicationRecord
  belongs_to :user
  belongs_to :stamp
end
