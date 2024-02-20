# frozen_string_literal: true

# == Schema Information
#
# Table name: offers
#
#  id               :bigint           not null, primary key
#  pledge_amount    :decimal(10, 2)   not null
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
#
# Foreign Keys
#
#  fk_rails_dff5737759  (car_id => cars.id)
#
class Offer < ApplicationRecord
  belongs_to :car
  has_many :booking, dependent: :destroy
end
