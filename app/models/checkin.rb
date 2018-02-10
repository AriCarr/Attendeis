class Checkin < ApplicationRecord
  belongs_to :attendance
  belongs_to :user
end
