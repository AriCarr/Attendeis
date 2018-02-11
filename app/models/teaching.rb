class Teaching < ApplicationRecord
  belongs_to :taught_courses, class_name: 'Course', foreign_key: 'course_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :course_id }
end
