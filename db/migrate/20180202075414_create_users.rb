class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: false do |t|
      t.string :uid, null: false
      t.string :name
      t.string :ip

      t.timestamps
    end

    add_index :users, :uid, unique: true

    create_table :courses do |t|
      t.string :name
      t.string :admin_uid

      t.timestamps
    end

    create_table :expectations do |t|
      t.string :user_id, index: true
      t.integer :course_id, index: true

      t.timestamps
    end
  end
end
