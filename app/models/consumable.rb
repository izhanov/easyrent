# == Schema Information
#
# Table name: consumables
#
#  id          :bigint           not null, primary key
#  description :string
#  lifetime    :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  car_id      :bigint           not null
#
# Indexes
#
#  index_consumables_on_car_id  (car_id)
#
# Foreign Keys
#
#  fk_rails_cda57baf44  (car_id => cars.id)
#
class Consumable < ApplicationRecord
  belongs_to :car
  has_many :consumable_logs, dependent: :destroy

  audited

  TITLES = %w[
    engine_oil
    brake_fluid
    transmission_oil
    antifreeze
    power_steering_fluid
    air_filter
    fuel_filter
    cabin_filter
    spark_plug
    timing_belt
    timing_chain
    brake_pads
    brake_discs
    clutch_kit
    shock_absorber
    stabilizer_link
    tie_rod_end
    ball_joint
    wheel_hub
  ]

  def title_ru
    I18n.t("activerecord.attributes.consumable.titles.#{title}")
  end
end
