class CustomersController < ApplicationController

  # skip_before_action :user_authenticate, only: [:new, :create]
  def index
    @programs = Programm.where(status: 'active')
  end

  def welcome
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      RegisterationMailer.welcome(@customer).deliver_now!
      flash[:notice] = "User created successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @customer = @current_user
  end

  def update
    if @current_user.update(customer_params)
      flash[:notice] = "Updated successfully"
      redirect_to customers_welcome_path
    else
      render :edit
    end
  end

  def destroy
    if @current_user.destroy
      flash[:notice] = "User destroyed successfully"
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :contact).merge(status: 'inactive')
  end
end
