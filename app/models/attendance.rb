class Attendance < ApplicationRecord
  belongs_to :course
  has_many :checkins
  has_many :users, through: :checkins
  validates :password, uniqueness: true, allow_nil: true

  def timestamp
    created_at.strftime('%m/%d/%y, %I:%M %p')
  end
end
