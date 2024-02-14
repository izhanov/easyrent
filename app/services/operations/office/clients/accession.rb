# frozen_string_literal: true

module Operations
  module Office
    module Clients
      class Accession < Base
        def call(car_park, params)
          ActiveRecord::Base.transaction do
            client = yield find_or_create(params)
            yield accession(car_park, client)
            Success(client)
          end
        end

        private

        def find_or_create(params)
          client = Client.where(
            identification_number: params[:identification_number]
          ).or(Client.where(phone: params[:phone])).first
          client ? Success(client) : create(params)
        end

        def create(params)
          operation = Operations::Office::Clients::Create.new
          operation.call(params)
        end

        def accession(car_park, client)
          car_park.clients_in_car_parks.create!(
            client: client
          )
          Success(true)
        end
      end
    end
  end
end
