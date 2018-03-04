module AttendancesHelper

  def absent_without_nil
    @absent.map { |u| User.new(uid: u.uid, name: (u.name.nil? ? '' : u.name)) }
  end

end
