class AddAppearanceToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :appearance, :string, null: false, default: 'clean'
  end
end
