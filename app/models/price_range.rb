# frozen_string_literal: true

# == Schema Information
#
# Table name: price_ranges
#
#  id          :bigint           not null, primary key
#  unit        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  car_park_id :bigint           not null
#
# Indexes
#
#  index_price_ranges_on_car_park_id  (car_park_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_fe6b1b4b36  (car_park_id => car_parks.id)
#
class PriceRange < ApplicationRecord
  belongs_to :car_park
  has_many :price_range_cells, dependent: :destroy

  accepts_nested_attributes_for :price_range_cells, allow_destroy: true

  UNITS = %w[day].freeze
end
