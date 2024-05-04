# frozen_string_literal: true

module Utils
  module Typesense
    module Cars
      class QueryBuilder
        attr_reader :query, :filters

        def initialize(query: nil, car_park_id: nil, status: nil)
          @query = query
          @filters = {"owner.id": car_park_id, "status" => status}
        end

        def call
          query_params = {
            q: query,
            query_by: "plate_number, owner.id, mark.title, mark.synonyms, status",
            query_by_weights: "5, 4, 3, 4, 3",
            infix: "always, off, always, always, always",
            per_page: 250
          }

          query_params.merge!(filter_by)
          query_params
        end

        private

        def filter_by
          filters.each_with_object({}) do |(filter_name, value), filter_by|
            if filter_by[:filter_by].present?
              if value.present?
                old_value = filter_by[:filter_by]
                filter_by[:filter_by] = old_value + " && #{filter_name}:= #{value}"
              end
            else
              if value.present?
                filter_by[:filter_by] = "#{filter_name}:= #{value}"
              end
            end
          end
        end
      end
    end
  end
end
