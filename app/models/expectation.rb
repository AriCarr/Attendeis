class Expectation < ApplicationRecord
  belongs_to :enrolled_course, class_name: 'Course', foreign_key: 'course_id'
  belongs_to :student, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :course_id }
end
