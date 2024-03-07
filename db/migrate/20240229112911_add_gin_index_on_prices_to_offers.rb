class AddGinIndexOnPricesToOffers < ActiveRecord::Migration[7.1]
  def change
    add_index :offers, :prices, using: :gin, opclass: :jsonb_path_ops
  end
end
