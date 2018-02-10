class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.string :password
      t.boolean :open, default: true
      t.integer :course_id

      t.timestamps
    end
  end
end
