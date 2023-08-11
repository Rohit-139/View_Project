class UsersController < ApplicationController

  skip_before_action :user_authenticate, only:[:login, :welcome]

  def login_portal
  end

  def welcome
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user.present?
      session[:current_user] = jwt_encode(user_id: user.id)
      render "/welcome"
    else
      render "/login_portal"
    end
  end

  def logout
    @current_user = nil
  end

end
