# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          booking = yield commit(validated_params.to_h)
          Success(booking)
        end

        private

        def validate(params)
          validation = Validations::Office::Bookings::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          booking = Booking.create!(params)
          Success(booking)
        end
      end
    end
  end
end
