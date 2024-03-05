class ModifyUserColumns < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :username, false
    change_column_null :users, :firstname, false
    change_column_null :users, :lastname, false
    add_index :users, :username, unique: true
  end
end
