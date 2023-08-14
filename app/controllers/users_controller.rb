class UsersController < ApplicationController

  skip_before_action :user_authenticate#, only:[:login, :welcome]

  def login_portal
  end

  def welcome
  end

  def choice
  end

  def register
    if params[:choice] == "Instructor"
      redirect_to new_instructors_url

    else
      redirect_to new_customers_path
    end
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user.present?
      session[:current_user] = jwt_encode(user_id: @user.id)
      render "instructors/welcome"
    else
      flash[:notice] = "Invalid email & password"
      redirect_to login_portal_path
    end
  end

  def logout
    @current_user = nil
  end

end
