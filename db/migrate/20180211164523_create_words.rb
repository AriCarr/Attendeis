class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :course_id

      t.timestamps
    end

    create_table :teachings do |t|
      t.string :user_id
      t.integer :course_id

      t.timestamps
    end

    remove_column :courses, :admin_uids, :string
    remove_column :courses, :dictionary, :string
  end
end
