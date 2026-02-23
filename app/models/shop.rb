class Shop < ApplicationRecord
  belongs_to :mall
  belongs_to :category
end
