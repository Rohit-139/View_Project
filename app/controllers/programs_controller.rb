class ProgramsController < ApplicationController

  def index
    if params[:name].present?
      @programs = @current_user.programms.where("name like ?","%#{params[:name]}%")
    else
      @programs = @current_userprogramms.all
    end
  end

  def show
    @program = @current_user.programms.find_by(id: params[:id])
  end

  def new
    @program = Programm.new
  end

  def create
    @program = @current_user.programms.new(program_params)
    if @program.save
      redirect_to programs_path
    else
      render :new
    end
  end

  def filter_on_status_basis
    @programs = @current_user.programms.where(status: params[:status])
  end

  def edit
  end

  def update
    @program = @current_user.programms.find_by(id:params[:id])
    if @program.status == params[:status]
      render plain: "Program has already #{params[:status]} "
    else
      @program.update(status: params[:status])
      render @program, status: :ok
    end
  rescue NoMethodError => e
    render plain: 'No Record found with this id'
  end

  def destroy
    @program = @current_user.programms.find_by(id:params[:id])
    @program.destroy
    render "instructors/welcome", message: 'Program deleted Successfully', status: :ok
  end

  private

  def program_params
    params.require(:programm).permit(:name, :category_id, :status, :video)
  end
end
