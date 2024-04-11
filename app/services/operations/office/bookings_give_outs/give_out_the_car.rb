# frozen_string_literal: true

module Operations
  module Office
    module BookingsGiveOuts
      class GiveOutTheCar < Base
        def call(params, booking, responsible)
          yield its_time_to_give_out?(booking)
          params = normalize_numbers(params)
          validated_params = yield validate(params.to_h)
          booking = yield commit(validated_params.to_h, booking, responsible)
          Success(booking)
        end

        private

        def its_time_to_give_out?(booking)
          if booking.starts_at.to_date <= Date.current
            Success(true)
          else
            Failure[:its_not_time_to_give_out_the_car, {}]
          end
        end

        def validate(params)
          validation = Validations::Office::BookingsGiveOuts::GiveOutTheCar.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, booking, responsible)
          booking.transaction do
            actual_starts_at = params[:actual_starts_at]
            actual_ends_at = params[:actual_ends_at]
            Operations::Office::Bookings::StartTheRent.new.call(booking, responsible, actual_starts_at, actual_ends_at)
            BookingGiveOutAppendix.create!(
              booking: booking,
              **params.except(:actual_starts_at, :actual_ends_at, :pickup_location)
            )
            Success(booking.reload)
          end
        end

        def normalize_numbers(params)
          %w[mileage_before_rent fuel_level_before_rent].each do |key|
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
