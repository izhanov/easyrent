# frozen_string_literal: true

module Operations
  module Office
    module Contracts
      class Create < Base
        def call(booking, responsible)
          contract = yield commit(booking, responsible)
          OfficeJobs::Documents::CreateContractJob.perform_later(contract, responsible)
          OfficeJobs::Documents::CreateApplicationOneJob.perform_later(contract, responsible)
          Success(contract)
        end

        private

        def commit(booking, responsible)
          rental_days = booking.booked_dates_count
          calculator = Utils::Bookings::Calculator.new(booking)
          contract_next_number = Utils::Contracts::NextNumber.new(booking)
          mileage_limit = RentalRule::MileageLimit.find(booking.offer.mileage_limit_id).value

          audit_as_user(responsible) do
            contract = Contract.create!(
              number: contract_next_number.get,
              booking: booking,
              date: booking.starts_at.to_date,
              cost_per_day: calculator.get(:price_for_rent_period),
              rental_days: rental_days,
              total_amount: calculator.run,
              pledge_amount: calculator.get(:booking_pledge_amount),
              prepayment_amount: calculator.get(:booking_prepayment_amount),
              services_total_amount: calculator.get(:services_total_amount),
              permissible_mileage_limit: rental_days * mileage_limit
            )
            Success(contract)
          end
        end
      end
    end
  end
end
