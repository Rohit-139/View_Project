class Programm < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrolls, dependent: :destroy

  has_one_attached :video

  validates :name, presence:true
  enum :status,[:Active, :active, :Inactive, :inactive]

end
