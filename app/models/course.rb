class Course < ApplicationRecord
  has_many :expectations
  has_many :users, through: :expectations

  def started
    !start.nil?
  end

end
