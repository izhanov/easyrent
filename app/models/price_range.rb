# frozen_string_literal: true

# == Schema Information
#
# Table name: price_ranges
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  unit       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_price_ranges_on_owner  (owner_type,owner_id) UNIQUE
#
class PriceRange < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :price_range_cells, dependent: :destroy

  UNITS = %w[day].freeze
end
