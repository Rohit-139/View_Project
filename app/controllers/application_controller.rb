class ApplicationController < ActionController::Base
  include JsonWebToken

  before_action :user_authenticate

  private

  def user_authenticate
    header = session[:current_user].split(" ").last if session[:current_user]
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue
      render 'users/login_portal', notice: "Invalid email & password"
  end

end
