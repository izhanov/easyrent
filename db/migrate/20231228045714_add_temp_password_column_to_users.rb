class AddTempPasswordColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :temp_password, :string
  end
end
