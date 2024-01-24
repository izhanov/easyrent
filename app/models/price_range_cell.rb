# frozen_string_literal: true

# == Schema Information
#
# Table name: price_range_cells
#
#  id             :bigint           not null, primary key
#  from           :integer          not null
#  to             :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price_range_id :bigint           not null
#
# Indexes
#
#  index_price_range_cells_on_price_range_id  (price_range_id)
#
# Foreign Keys
#
#  fk_rails_a5b02c5a03  (price_range_id => price_ranges.id)
#
class PriceRangeCell < ApplicationRecord
  belongs_to :price_range

  def range
    from..to
  end
end
