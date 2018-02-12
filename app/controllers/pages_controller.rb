class PagesController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      @taught_courses = current_user.taught_courses
      enrolled_courses = current_user.enrolled_courses.select(&:open)
      @enrolled_courses = enrolled_courses unless enrolled_courses.count.zero?
      redirect_to @taught_courses.first if @taught_courses.count == 1 && !@enrolled_courses
    end
  end
end
