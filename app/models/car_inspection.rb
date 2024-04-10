# frozen_string_literal: true

# == Schema Information
#
# Table name: car_inspections
#
#  id         :bigint           not null, primary key
#  end_at     :date
#  start_at   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint           not null
#
# Indexes
#
#  index_car_inspections_on_car_id  (car_id)
#
# Foreign Keys
#
#  fk_rails_46ec05e4d0  (car_id => cars.id)
#
class CarInspection < ApplicationRecord
  belongs_to :car

  scope :active, -> { where('end_at >= ?', Date.today) }

  audited

  def active?
    end_at >= Date.today
  end
end
