# frozen_string_literal: true

module Validations
  module Office
    module Bookings
      class Update < Base
        params do
          required(:offer_id).filled(:integer)
          required(:starts_at).filled(:time)
          required(:ends_at).filled(:time)
          required(:pickup_location).filled(:string)
          required(:drop_off_location).filled(:string)
          optional(:with_pledge_amount).value(:bool)
          optional(:pledge_amount).value(:decimal)
          optional(:services).value(:hash)
        end
      end
    end
  end
end
