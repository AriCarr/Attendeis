class Course < ApplicationRecord
  has_many :expectations
  has_many :users, through: :expectations
  has_many :attendances

  def open
    open_attendances > 0
  end

end
