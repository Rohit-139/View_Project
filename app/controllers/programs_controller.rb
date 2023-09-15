class ProgramsController < ApplicationController
  def index
    if params[:choice] == "name" && params[:name].present?
      @programs = @current_user.programms.where("name like ?","%#{params[:name]}%")
    elsif params[:choice] == "status" && params[:name].present?
      if (params[:name] == "active" || params[:name] == "Active")
        @programs = @current_user.programms.active
      elsif params[:name] == "inactive" || params[:name]=="Inactive"
        @programs = @current_user.programms.inactive
      else
        @programs = @current_user.programms.all
      end
    else
      @programs = @current_user.programms.all
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
      flash[:notice] = "Created Successfully"
      redirect_to instructors_welcome_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @program = Program.find(params[:id])

    if @program.update(program_params)
      falsh[:notice] = "Updated successfully"
      redirect_to @program
    else
      falsh[:notice] = "Updation Failed"
      render :edit
    end
  end

  def destroy
    @program = Programm.find(params[:id])

    if @program.destroy
      flash[:notice] = "Deleted Successfully"
      redirect_to instructors_welcome_path
    else
      render :show
    end
  end

  private

  def program_params
    params.require(:programm).permit(:name, :category_id, :status, :video)
  end
end
