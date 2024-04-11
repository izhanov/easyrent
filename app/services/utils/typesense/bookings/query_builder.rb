# frozen_string_literal: true

module Utils
  module Typesense
    module Bookings
      class QueryBuilder
        attr_reader :query, :filters

        def initialize(query: nil, car_park_id: nil, starts_at: nil)
          @query = query
          @filters = {"car.owner.id" => car_park_id, "starts_at" => starts_at}
        end

        def call
          query_params = {
            q: query.presence || "*",
            query_by: "number, car.plate_number, offer.title, car.owner.title",
            query_by_weights: "5, 4, 3, 3"
          }

          query_params.merge!(filter_by)

          query_params
        end

        private

        def filter_by
          return {} if filters.values.all?(&:blank?)

          filter_by_car_park_id = filters["car.owner.id"] if filters["car.owner.id"].present?
          filter_by_starts_at = cast_date_to_integer(filters["starts_at"]) if filters["starts_at"].present?
          filter_by_ends_at = cast_date_to_integer(filters["ends_at"]) if filters["ends_at"].present?

          case [filter_by_car_park_id, filter_by_starts_at, filter_by_ends_at]
          in [String, Array, Array]
            {filter_by: "car.owner.id:= #{filter_by_car_park_id} && starts_at:= #{filter_by_starts_at}"}
          in [nil, Array, Array]
            {filter_by: "starts_at:= #{filter_by_starts_at}"}
          in [String, nil, Array]
            {filter_by: "car.owner.id:= #{filter_by_car_park_id} && ends_at:= #{filter_by_ends_at}"}
          in [String, Array, nil]
            {filter_by: "car.owner.id:= #{filter_by_car_park_id} && starts_at:= #{filter_by_starts_at}"}
          in [String, nil, nil]
            {filter_by: "car.owner.id:= #{filter_by_car_park_id}"}
          in [nil, Array, Array]
            {filter_by: "starts_at:= [#{filter_by_starts_at.first}..#{filter_by_ends_at.last}]"}
          in [nil, nil, Array]
            {filter_by: "ends_at:= #{filter_by_ends_at}"}
          in [nil, Array, nil]
            {filter_by: "starts_at:= #{filter_by_starts_at}"}
          else
            {}
          end
        end

        def cast_date_to_integer(value)
          [Time.zone.parse(value).to_i..Time.zone.parse(value).end_of_day.to_i]
        end
      end
    end
  end
end
