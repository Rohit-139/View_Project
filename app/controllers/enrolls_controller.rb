class EnrollsController < ApplicationController

  def index
    if params[:name].present?
      @enrolls = current_user.enrolls.where("name LIKE '%#{params[:name]}'")
    else
      @enrolls = current_user.enrolls
    end
  end

  def show
    @id = params[:id]
    @enroll = Programm.joins(:enrolls).find_by(enrolls: {id: params[:id] })
  end

  def category_wise_courses
    @programs = Programm.joins(:category).where('categories.name like ?',"%#{params[:name]}%")
  end

  def new_enroll
    program = Programm.find_by(id: params[:id])
    @enroll = current_user.enrolls.new(name: program.name, status: 'started',  programm_id: program.id)
    if @enroll.save
      flash[:notice] = "You have Successfully enrolled"
      redirect_to customers_welcome_path
    else
      flash[:notice] = "You have already enrolled in this course"
      render "customers/welcome"
    end
  end

  def edit
    @enroll = Enroll.find_by(id:params[:id])
  end

  def update
    byebug
    @enroll = Enroll.find_by(id:params[:id])
    if @enroll.status == params[:status]
      redirect_to enroll_path
    else
      @current_user.enrolls.update(level: 'finished')
      flash[:plain]= 'Successfully Marked as Finished'
      render
    end
  end

  def destroy
    @enroll = current_user.enrolls.find_by(id:params[:id])
    @enroll.destroy
    render "/welcome"
  end

end
