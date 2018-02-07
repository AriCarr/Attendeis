class PagesController < ApplicationController
  skip_before_action :require_login
  def index
      @courses = Course.select { |c| c.admin_uids.include? current_user.uid  } if current_user
  end
end
