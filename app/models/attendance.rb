class Attendance < ApplicationRecord
  belongs_to :course
  has_many :checkins
  has_many :users, through: :checkins
  alias_attribute :timestamp, :created_at
  validates :password, uniqueness: true, allow_nil: true

end
