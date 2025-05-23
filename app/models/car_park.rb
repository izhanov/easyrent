# == Schema Information
#
# Table name: car_parks
#
#  id                  :bigint           not null, primary key
#  bank_account_number :string
#  bank_code           :string
#  bank_name           :string
#  benificiary_code    :string
#  booking_prefix      :string(4)        default("UNDF"), not null
#  business_id_number  :string           not null
#  card_id_number      :string
#  contact_phone       :string
#  email               :string
#  kind                :string           not null
#  legal_address       :string
#  privateer_date      :date
#  privateer_number    :string
#  residence_address   :string
#  service_phone       :string
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  city_id             :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_car_parks_on_booking_prefix                  (booking_prefix) UNIQUE WHERE (booking_prefix IS NOT NULL)
#  index_car_parks_on_city_id                         (city_id)
#  index_car_parks_on_city_id_and_business_id_number  (city_id,business_id_number) UNIQUE
#  index_car_parks_on_user_id                         (user_id)
#
# Foreign Keys
#
#  fk_rails_792492b27c  (city_id => cities.id)
#  fk_rails_c7ee0732ff  (user_id => users.id)
#
class CarPark < ApplicationRecord
  belongs_to :city
  belongs_to :user

  has_one :price_range, dependent: :destroy, class_name: "PriceRange", as: :owner

  has_many :additional_services, as: :owner, dependent: :destroy
  has_many :cars, as: :owner, dependent: :destroy, class_name: "Car"
  has_many :bookings, through: :cars, dependent: :destroy
  has_many :clients, through: :user, source: :clients
  has_many :document_templates, as: :owner, dependent: :destroy

  # Rental rules associations
  has_one :age_restriction, as: :owner, dependent: :destroy, class_name: "RentalRule::AgeRestriction"
  has_one :driving_experience, as: :owner, dependent: :destroy, class_name: "RentalRule::DrivingExperience"
  has_many :mileage_limits, as: :owner, dependent: :destroy, class_name: "RentalRule::MileageLimit"
  has_one :minimal_period, as: :owner, dependent: :destroy, class_name: "RentalRule::MinimalPeriod"

  # Kinds of car parks business forms
  # llp - Limited Liability Partnership (ТОО)
  # ie - Individual Entrepreneur (ИП)
  KINDS = %w[llp ie]

  def llp?
    kind == "llp"
  end

  def ie?
    kind == "ie"
  end

  def vacant_cars_count
    bookings.size.positive? ? cars.vacant.size : cars.size
  end

  def booked_cars_count
    bookings.size.positive? ? cars.booked.size : 0
  end

  def occupied_cars_count
    bookings.size.positive? ? cars.occupied.size : 0
  end
end
