class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy, :stop, :restart, :require_course_admin, :change]
  before_action :require_course_admin, except: [:create]

  def require_course_admin
    redirect_to root_path unless current_user.taught_courses.include? @course
  end

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    get_present
  end

  def get_present
    @present = @attendance.students
    @absent = @course.students - @present
  end

  def change
    user = User.find(params[:uid])
    if params[:present] == 'present'
      @attendance.students << user
    else
      @attendance.students.delete(user)
    end

    get_present

    respond_to do |format|
      format.js
    end
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    if current_user.taught_courses.include? params[:course_id]
      redirect_to root_path
    else
      @attendance = Attendance.new(attendance_params)
      set_password

      respond_to do |format|
        if @attendance.save
          format.html { redirect_to @attendance }
          format.json { render :show, status: :created, location: @attendance }
        else
          format.html { render :new }
          format.json { render json: @attendance.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def set_password
    loop do
      pass_arr = @attendance.course.words.sample(3).pluck(:word)
      @attendance.password = "#{pass_arr[0]} #{pass_arr[1]} #{pass_arr[2]}".strip
      @attendance.save
      break unless @attendance.password.nil?
    end
    course = @attendance.course
    course.open_attendances += 1
    course.save
  end

  def stop
    @attendance.open = false
    @attendance.save
    @course.open_attendances -= 1
    @course.save
    redirect_to @attendance
  end

  def restart
    @attendance.open = true
    @attendance.save
    set_password
    redirect_to @attendance
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(attendance_params[:id])
      @course = @attendance.course
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.permit(:id, :password, :open, :course_id, :uid, :present)
    end
end
