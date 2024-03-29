class User < ApplicationRecord

  has_many :programms, dependent: :destroy
  has_many :enrolls, dependent: :destroy

  validates :name, presence:true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :email, presence:true, uniqueness:true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true, format: {with: /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x}

end
