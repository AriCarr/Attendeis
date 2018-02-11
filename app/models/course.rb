class Course < ApplicationRecord
  has_many :expectations
  has_many :students, through: :expectations
  has_many :teachings
  has_many :teachers, through: :teachings
  has_many :attendances
  has_many :words

  def open
    open_attendances.positive?
  end

end
