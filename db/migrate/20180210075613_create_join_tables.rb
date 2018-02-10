class CreateJoinTables < ActiveRecord::Migration[5.0]
  def change
    create_table :expectations do |t|
      t.string :user_id
      t.integer :course_id

      t.timestamps
    end

    create_table :checkins do |t|
      t.string :user_id
      t.integer :attendance_id

      t.timestamps
    end
  end
end
