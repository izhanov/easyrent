# frozen_string_literal: true

# == Schema Information
#
# Table name: marks
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  synonyms   :jsonb            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           not null
#
# Indexes
#
#  index_marks_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_0f38256888  (brand_id => brands.id)
#
class Mark < ApplicationRecord
  belongs_to :brand

  BODY_TYPES = %w[
    sedan
    hatchback
    universal
    coupe
    convertible
    suv
    pickup
    minivan
    van
    limousine
    crossover
    roadster
    truck
    bus
    other
  ].freeze
end
