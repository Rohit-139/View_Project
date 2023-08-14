class EnrollsController < ApiController


  def index
    if params[:name].present?
      @enrolls = @current_user.enrolls.where("name LIKE '%#{params[:name]}'")
    else
      @enrolls = @current_user.enrolls
    end
  end

  def show
    @enroll = @current_user.enrolls.find_by(id: params[:id])
  end

  def category_wise_courses
    @programs = Programm.joins(:category).where('categories.name like ?',"%#{params[:name]}%")
  end

  def new
    @enroll = Enroll.new
  end

  def create
    program = Programm.find_by(name: params[:name], status: 'active')
    if program.present?
      @enroll = @current_user.enrolls.new(name: program.name, status: 'started', programm_id: program.id)
      if @enroll.save
        render @enroll, status: :created
      else
        render "/welcome", @enroll.errors.messages
      end
    else
      render "/welcome",notice: 'No Course found with this name'
    end
  end

  def update
    @enroll = @current_user.enrolls.find_by(id:params[:id])
    if @enroll.level == params[:status]
      render @enroll, notice: "Program has already #{params[:status]} status"
    else
      @current_user.enrolls.update(level: 'finished')
      render plain: 'Successfully Marked as Finished', status: :ok
    end
  end

  def destroy
    @enroll = @current_user.enrolls.find_by(id:params[:id])
    @enroll.destroy
    render "/welcome", notice: 'Deleted Successfully' }
  end

end
