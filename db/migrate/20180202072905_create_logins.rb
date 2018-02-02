class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
