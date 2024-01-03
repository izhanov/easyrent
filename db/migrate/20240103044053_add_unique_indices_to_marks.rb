class AddUniqueIndicesToMarks < ActiveRecord::Migration[7.1]
  def change
    add_index :marks, :title, unique: true
  end
end
