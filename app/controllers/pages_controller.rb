class PagesController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      @courses_taught = Course.select { |c| c.admin_uids.include? current_user.uid }
      courses = current_user.courses.select(&:open)
      @courses = courses unless courses.count.zero?
      redirect_to @courses_taught.first if @courses_taught.count == 1 && !@courses
    end
  end
end
