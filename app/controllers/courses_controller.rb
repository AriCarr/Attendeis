class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def require_admin
    set_course
    redirect_to root_path unless @course.admin_uids.include? current_user.uid
  end

  def enroll
    set_course
    uid = params[:student].downcase
    @course.users << User.find_or_create_by(uid: uid) unless @course.admin_uids.include? uid

    respond_to do |format|
      format.js
    end
  end

  def unenroll
    set_course
    @course.users.delete(User.find(params[:student]))

    respond_to do |format|
      format.js
    end
  end

  def admin_add
    set_course
    word = params[:uid].downcase
    @course.admin_uids << word unless @course.admin_uids.include? word
    @course.save

    respond_to do |format|
      format.js
    end
  end

  def admin_remove
    set_course
    @course.admin_uids.delete(params[:uid])
    @course.save

    respond_to do |format|
      format.js
    end
  end

  def dict_add
    set_course
    word = params[:word].downcase
    @course.dictionary << word unless @course.dictionary.include? word
    @course.save

    respond_to do |format|
      format.js
    end
  end

  def dict_remove
    set_course
    @course.dictionary.delete(params[:word])
    @course.save

    respond_to do |format|
      format.js
    end
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @last_attendance = @course.attendances.where(open: false).last
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :admin_uid)
    end
end
