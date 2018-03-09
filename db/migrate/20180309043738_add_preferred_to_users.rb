class AddPreferredToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preferred, :boolean, default: false
  end
end
