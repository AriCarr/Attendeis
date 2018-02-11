class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :require_admin]
  before_action :require_admin

  def require_admin
    redirect_to root_path unless is_admin current_user
  end

  def is_admin(user)
    set_course
    @course.teachers.include? user
  end

  def enroll
    set_course
    uid = params[:student].downcase
    user = User.find_or_create_by(uid: uid)
    user.enrolled_courses << @course unless is_admin(user)

    respond_to do |format|
      format.js
    end
  end

  def unenroll
    set_course
    @course.students.delete(User.find(params[:student]))

    respond_to do |format|
      format.js
    end
  end

  def teacher_add
    set_course
    user = User.find_or_create_by(uid: params[:uid].downcase)
    user.taught_courses << @course

    respond_to do |format|
      format.js
    end
  end

  def teacher_remove
    set_course
    @course.teachers.delete(User.find(params[:uid].downcase))
    @course.save

    respond_to do |format|
      format.js
    end
  end

  def dict_add
    set_course
    word = params[:word].downcase.strip
    @course.words << Word.create(word: word) unless @course.words.include? word
    @course.save

    respond_to do |format|
      format.js
    end
  end

  def dict_remove
    set_course
    # byebug
    word = params[:word]
    Word.find(params[:word]).destroy
    params[:word] = nil

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
    running = @course.attendances.where(open: true).reverse
    @past = (@course.attendances - running).reverse
    @running = running unless running.count == 0
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
