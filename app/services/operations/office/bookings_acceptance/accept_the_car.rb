# frozen_string_literal: true

module Operations
  module Office
    module BookingsAcceptance
      class AcceptTheCar < Base
        def call(params, booking, responsible)
          params = normalize_numbers(params)
          validated_params = yield validate(params.to_h)
          booking = yield commit(validated_params.to_h, booking, responsible)
          Success(booking)
        end

        private

        def validate(params)
          validation = Validations::Office::BookingsAcceptance::AcceptTheCar.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, booking, responsible)
          booking.with_lock do
            actual_ends_at = params[:actual_ends_at]
            Operations::Office::Bookings::ReturnTheDeposit.new.call(booking, responsible, actual_ends_at)
            BookingAcceptanceAppendix.create!(
              booking: booking,
              **params.except(:actual_ends_at)
            )
            Success(booking.reload)
          end
        end

        def normalize_numbers(params)
          %w[mileage_after_rent car_wash_amount fine_amount return_from_address_amount].each do |key|
            if params.key?(key)
              params[key] = params[key].to_s.gsub(/[^0-9,.]/, "").to_f
            end
          end
          params
        end
      end
    end
  end
end
