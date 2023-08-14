class InstructorsController < ApplicationController

  skip_before_action :user_authenticate, only: [:new, :create]

  def welcome
    @current_user
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
      flash[:notice] = "Successfully created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @instructor = @current_user
  end

  def update
    @instructor = @current_user
    if @instructor.update(instruct_params)
      flash[:notice] = "Updated successfully"
      redirect_to "/welcome"
    else
      render :edit
    end

  end

  def destroy
    if @current_user.destroy
      flash[:notice] = "User destroyed successfully"
      redirect_to root_path
    else
      render 
    end
  end

  private

  def instruct_params
    params.require(:instructor).permit(:name, :email, :password, :contact)
  end

end
