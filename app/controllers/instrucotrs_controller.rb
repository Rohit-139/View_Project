class InstructorsController < ApiController

  skip_before_action :user_authenticate, only: [:new, :create]

  def welcome
  end

  def show
    @current_user
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instruct_params)
    if @instructor.save
      redirect_to root_path, notice: "Instructor created successfully"
    else
       render root_path, notice: "Please fill valid credentials"
    end
  end

  def edit
  end

  def update
    @current_user.update
  end

  def destroy
    if @current_user.destroy
      render root_path, notice: "User destroyed successfully"
    else
      render 
    end
  end

  private

  def instruct_params
    params.permit(:name, :email, :password, :contact)
  end

end
