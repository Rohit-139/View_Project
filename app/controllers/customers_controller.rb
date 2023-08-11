class CustomersController < ApiController

  # skip_before_action :user_authenticate, only: [:new, :create]
  def index
    @programs = Program.where(status: 'active')
  end

  def welcome
  end

  def show
    @current_user
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render root_path, notice: "Created Successfully"
    else
      render root_path, notice: "Please fill valid credentials"
    end
  end

  def destroy
    if @current_user.destroy
      redirect_to root_path, notice: "User destroyed successfully"
    else
      render :show
    end
  end

  private

  def customer_params
    params.permit(:name, :email, :password, :contact)
  end
end
