# frozen_string_literal: true

# == Schema Information
#
# Table name: car_insurances
#
#  id         :bigint           not null, primary key
#  end_at     :date
#  kind       :string
#  start_at   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint           not null
#
# Indexes
#
#  index_car_insurances_on_car_id  (car_id)
#
# Foreign Keys
#
#  fk_rails_ae90286056  (car_id => cars.id)
#
class CarInsurance < ApplicationRecord
  belongs_to :car

  scope :active, -> { where('end_at >= ?', Date.today) }

  audited

  KINDS = %w[ogpo kasko].freeze

  def remaining_days
    (end_at - Date.today).to_i
  end

  def active?
    end_at >= Date.today
  end
end
