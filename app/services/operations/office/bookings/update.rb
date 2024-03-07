# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Update < Base
        def call(booking, params, responsible)
          validated_params = yield validate(params)
          yield vacant?(booking, validated_params.to_h) if change_dates?(booking, validated_params.to_h)
          updated_booking = yield commit(booking, validated_params.to_h, responsible)
          Success(updated_booking)
        end

        private

        def validate(params)
          validation = Validations::Office::Bookings::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(booking, params, responsible)
          audit_as_user(responsible) do
            booking.update!(params)
          end
          Success(booking.reload)
        end

        def change_dates?(booking, params)
          new_starts_at = params[:starts_at].to_date
          new_ends_at = params[:ends_at].to_date
          booking.starts_at != new_starts_at || booking.ends_at != new_ends_at
        end

        def vacant?(booking, params)
          bookings = Booking.left_joins(:car).where(
            bookings_table[:starts_at].between(params[:starts_at]..params[:ends_at])
              .or(bookings_table[:ends_at].between(params[:starts_at]..params[:ends_at])).and(
                bookings_table[:car_id].eq(booking.car_id)
              ).and(bookings_table[:id].not_eq(booking.id))
          )

          if bookings.any?
            booked_dates = bookings.map do |booking|
              start_date = booking.starts_at.strftime("%d/%m/%Y")
              end_date = booking.ends_at.strftime("%d/%m/%Y")
              [start_date, end_date].join(" - ")
            end.join(", ")

            Failure[:car_is_not_vacant, {booking_dates: [booked_dates]}]
          else
            Success(true)
          end
        end

        def bookings_table
          Booking.arel_table
        end
      end
    end
  end
end
