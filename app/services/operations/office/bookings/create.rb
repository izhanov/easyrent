# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class Create < Base
        def call(params, responsible)
          validated_params = yield validate(params)

          car_id = validated_params[:car_id]
          starts_at = validated_params[:starts_at]
          ends_at = validated_params[:ends_at]
          yield vacant?(car_id, starts_at, ends_at)
          booking = yield commit(validated_params.to_h, responsible)
          Success(booking)
        end

        private

        def validate(params)
          validation = Validations::Office::Bookings::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def vacant?(car_id, starts_at, ends_at)
          bookings = Booking.left_joins(:car).where(
            bookings_table.grouping(
              bookings_table[:starts_at].between(starts_at..ends_at).or(
                bookings_table[:ends_at].between(starts_at..ends_at)
              ).or(
                bookings_table[:starts_at].lt(starts_at).and(bookings_table[:ends_at].gt(ends_at))
              )
            ).and(
              bookings_table[:car_id].eq(car_id)
            ).and(
              bookings_table[:status].not_in(["completed", "cancelled"])
            )
          )

          if bookings.any?
            booked_dates = bookings.map do |booking|
              start_date = booking.starts_at.strftime("%d/%m/%Y")
              end_date = booking.ends_at.strftime("%d/%m/%Y")
              [start_date, end_date].join(" - ")
            end.join(", ")
            error_message = I18n.t("operations.office.bookings.create.car_is_not_vacant", booked_dates: booked_dates)
            Failure[:car_is_not_vacant, {booking: [error_message]}]
          else
            Success(true)
          end
        end

        def commit(params, responsible)
          ActiveRecord::Base.transaction do
            booking_number = Utils::Bookings::NextNumber.new(params[:car_id]).get
            audit_as_user(responsible) do
              booking = Booking.create!(params.merge(number: booking_number))
              Operations::Office::Cars::Book.new.call(booking.car, responsible)
              Success(booking)
            end
          end
        end

        def bookings_table
          Booking.arel_table
        end
      end
    end
  end
end
