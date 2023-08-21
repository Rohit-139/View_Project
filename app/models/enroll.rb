class Enroll < ApplicationRecord
  belongs_to :programm
  belongs_to :user

  enum :status, [:Started, :started, :Pending, :pending]
  validates :programm_id, uniqueness: {scope: :user_id, message:"You have already enrolled in this course"}

end
