class Word < ApplicationRecord
  belongs_to :course

  validates :word, uniqueness: { scope: :course_id }
end
