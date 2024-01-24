# == Schema Information
#
# Table name: car_parks
#
#  id                  :bigint           not null, primary key
#  bank_account_number :string
#  bank_code           :string
#  bank_name           :string
#  benificiary_code    :string
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
  has_many :cars, as: :ownerable, dependent: :destroy
  # Kinds of car parks business forms
  # llp - Limited Liability Partnership (ТОО)
  # ie - Individual Entrepreneur (ИП)
  KINDS = %w[llp ie]
end
