class UsersController < ApplicationController

  # skip_before_action :user_authenticate, only: [:login, :welcome, :register, :choice, :verify,  :verify_otp]

  def login_portal
  end

  def choice
  end

  def register
    if params[:choice] == "Instructor"
      redirect_to new_instructor_url
    else
      redirect_to new_customer_path
    end
  end

  def verify
    @user = User.find_by(id: params[:id])
    otp = rand.to_s[2..7]
    @a = Time.now.strftime('%s')
    RegisterationMailer.send_otp(@user,otp).deliver_now
    @user.update(otp: otp)
  end

  def verify_otp
    @user = User.find(params[:id])
    if @user.otp == params[:otp].to_i
      @user.update(status: 'active')
      render :login_portal
    else
      flash[:notice] = "Invalid OTP"
      redirect_to "/verify/#{@user.id}"
    end
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user.present?
      if @user.status == 'active'
        session[:current_user] = jwt_encode(user_id: @user.id)
        if @user.type == "Instructor"
          redirect_to instructors_welcome_path
        else
          redirect_to customers_welcome_path
        end
      else
        flash[:notice] = "Invalid email & password"
        render :login_portal
      end
    else
      flash[:notice] = "Invalid email & password"
      redirect_to login_portal_path
    end
  end

  def logout
    session.delete(:current_user)
    flash[:notice] = "Logged out Successfully"
    redirect_to root_path
  end

  def password
    @user = @current_user
  end

  def change_password
    if @current_user.password == params[:current_password]
      if params[:new_password] == params[:confirm_password]
        if @current_user.update(password: params[:new_password])
          flash[:notice] = "Password Changed"
          redirect_to instructors_welcome_path
        else
          flash[:notice] = "New password not fullfill the requirements"
        end
      else
        flash[:notice] = "Password mismatched"
        redirect_to password_path
      end
    else
      flash[:notice] = "Wrong Current Password"
      redirect_to password_path
    end
  end

end
