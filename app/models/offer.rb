# frozen_string_literal: true

# == Schema Information
#
# Table name: offers
#
#  id               :bigint           not null, primary key
#  prices           :jsonb            not null
#  published        :boolean          default(FALSE), not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  car_id           :bigint           not null
#  mileage_limit_id :integer          not null
#
# Indexes
#
#  index_offers_on_car_id  (car_id)
#  index_offers_on_prices  (prices) USING gin
#
# Foreign Keys
#
#  fk_rails_dff5737759  (car_id => cars.id)
#
class Offer < ApplicationRecord
  belongs_to :car
  has_many :booking, dependent: :destroy, inverse_of: :offer

  audited
end
