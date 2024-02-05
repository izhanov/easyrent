# == Schema Information
#
# Table name: clients_in_car_parks
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  car_park_id :bigint           not null
#  client_id   :bigint           not null
#
# Indexes
#
#  index_clients_in_car_parks_on_car_park_id  (car_park_id)
#  index_clients_in_car_parks_on_client_id    (client_id)
#
# Foreign Keys
#
#  fk_rails_422e651a18  (car_park_id => car_parks.id)
#  fk_rails_f7ec30b2c3  (client_id => clients.id)
#
class ClientsInCarPark < ApplicationRecord
  belongs_to :client
  belongs_to :car_park
end
