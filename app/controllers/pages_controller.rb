class PagesController < ApplicationController
  # skip_before_action :require_login
  def index
      if current_user
        @courses = Course.where(admin_uid: current_user.uid)
      end
  end
end
