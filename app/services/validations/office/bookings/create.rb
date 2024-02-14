# frozen_string_literal: true

module Validations
  module Office
    module Bookings
      class Create < Base
        params do
          required(:car_id).filled(:integer)
          required(:client_id).filled(:integer)
          required(:offer_id).filled(:integer)
          required(:starts_at).filled(:time)
          required(:ends_at).filled(:time)
          required(:pickup_location).filled(:string)
          required(:drop_off_location).filled(:string)
          optional(:services).value(:hash)
        end

        rule(:starts_at) do
          key.failure(:in_the_past) if value < Time.current
        end

        rule(:ends_at) do
          key.failure(:in_the_past) if value < Time.current
          key.failure(:less_than_starts_at) if value < values[:starts_at]
        end
      end
    end
  end
end
