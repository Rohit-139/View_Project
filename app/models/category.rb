class Category < ApplicationRecord
  has_many :programs, dependent: :destroy
end
