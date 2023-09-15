class RegisterationMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Registration')
  end

  def send_otp(user,otp)
    @otp = otp
    @user = user
    mail(to: @user.email, subject: "OTP- One Time Password for Verfication" )
  end

end
