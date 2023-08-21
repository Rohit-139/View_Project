class UsersController < ApplicationController

  skip_before_action :user_authenticate, only:[:login, :welcome, :register, :choice]

  def login_portal
  end

  def choice
  end

  def register
    # byebug
    if params[:choice] == "Instructor"
      redirect_to new_instructor_url

    else
      redirect_to new_customer_path
    end
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user.present?
      session[:current_user] = jwt_encode(user_id: @user.id)
      if @user.type == "Instructor"
        redirect_to instructors_welcome_path
      else
        redirect_to customers_welcome_path
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
    # byebug
    if @current_user.password == params[:current_password]
      if params[:new_password] == params[:confirm_password]
        @current_user.update(password: params[:new_password])
        flash[:notice] = "Password Changed"
        redirect_to instructors_welcome_path
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
