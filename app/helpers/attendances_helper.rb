module AttendancesHelper

  def without_nil(list)
    list.map { |u| User.new(uid: u.uid, name: (u.name.nil? ? '' : u.name)) }
  end

end
