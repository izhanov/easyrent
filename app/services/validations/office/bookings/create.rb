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
          required(:payment_method).filled(:string)
          optional(:without_prepayment_amount).value(:bool)
          optional(:prepayment_amount).value(:decimal)
          optional(:prepayment_method).value(:string)
          optional(:with_pledge_amount).value(:bool)
          optional(:pledge_amount).value(:decimal)
          optional(:pledge_method).value(:string)
          optional(:kaspi_method_amount).value(:decimal)
          optional(:halyk_method_amount).value(:decimal)
          optional(:cash_method_amount).value(:decimal)
          optional(:services).value(:hash)
          optional(:comments_attributes).value(:hash)
        end

        rule(:starts_at) do
          key.failure(:in_the_past) if value < Time.current
        end

        rule(:ends_at) do
          key.failure(:in_the_past) if value < Time.current
          key.failure(:less_than_starts_at) if value < values[:starts_at]
        end

        rule(:pledge_amount) do
          if key?
            key.failure(:less_than_zero) if value < 0 && values[:with_pledge_amount]
          end
        end
      end
    end
  end
end
