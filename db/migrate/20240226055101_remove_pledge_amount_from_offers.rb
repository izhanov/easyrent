class RemovePledgeAmountFromOffers < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        remove_column :offers, :pledge_amount, :decimal
      end

      dir.down do
        add_column :offers, :pledge_amount, :decimal, default: 0.0, null: false, precision: 10, scale: 2
      end
    end
  end
end
