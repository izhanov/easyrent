class AddTechnicalConditionToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :technical_condition, :string, null: false, default: 'good'
  end
end
