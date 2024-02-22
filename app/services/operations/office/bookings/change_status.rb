# frozen_string_literal: true

module Operations
  module Office
    module Bookings
      class ChangeStatus < Base
        def call(booking, status)
          validated_status = yield validate(status)
          updated_booking = yield commit(booking, validated_status)
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

        def commit(booking, status)
          booking.update!(status: status)
          Success(booking.reload)
        end
      end
    end
  end
end
