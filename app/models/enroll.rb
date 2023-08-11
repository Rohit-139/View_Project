class Enroll < ApplicationRecord
  belongs_to :programm
  belongs_to :customer

  enum :status, [:Started, :Pending, :pending]
  validates :program_id, uniqueness: {scope: :user_id, message:"You have already enrolled in this course"}

end
