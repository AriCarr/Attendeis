class Course < ApplicationRecord
  has_many :expectations
  has_many :users, through: :expectations
end
