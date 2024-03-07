# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class ChangeStatus < Base
        OPERATION_BY_STATUS = {
          "confirmed" => "confirm",
          "payment_accepted" => "accept_payment",
          "give_out_the_car" => "give_out_the_car",
          "start_the_rent" => "start_the_rent",
          "end_the_rent" => "end_the_rent",
          "accept_the_car" => "accept_the_car",
          "return_the_deposit" => "return_the_deposit",
          "cancelled" => "cancel",
          "completed" => "complete"
        }

        def call(booking, status, responsible)
          validated_status = yield validate(status)
          updated_booking = yield process(booking, validated_status, responsible)
          Success(updated_booking)
        end

        private

        def validate(status)
          if Booking::STATUSES.include?(status)
            Success(status)
          else
            error_message = [
              I18n.t("dry_validation.errors.rules.booking.status.invalid")
            ]
            Failure[:validation_error, {status: error_message}]
          end
        end

        def process(booking, status, responsible)
          operation =
            "Operations::Office::Bookings::#{OPERATION_BY_STATUS[status].camelize}".constantize.new
          operation.call(booking, responsible)
        end
      end
    end
  end
end
