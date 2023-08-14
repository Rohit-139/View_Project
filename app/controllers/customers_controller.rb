class CustomersController < ApplicationController

  skip_before_action :user_authenticate, only: [:new, :create]
  def index
    @programs = Program.where(status: 'active')
  end

  def welcome
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = "User created successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @current_user.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :contact)
  end
end
