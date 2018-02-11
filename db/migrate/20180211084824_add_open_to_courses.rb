class AddOpenToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :open_attendances, :integer, default: 0
  end
end
