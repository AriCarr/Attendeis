class PagesController < ApplicationController
  # skip_before_action :require_login
  def index
      @courses = Course.where(admin_uid: current_user.uid) if current_user
  end
end
