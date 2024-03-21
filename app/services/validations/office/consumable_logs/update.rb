# frozen_string_literal: true

module Validations
  module Office
    module ConsumableLogs
      class Update < Base
        params do
          required(:date).filled(:date)
          required(:mileage_when_replacing).filled(:integer)
          required(:mileage_at_next_replacing).filled(:integer)
          optional(:description).value(:string)
        end
      end
    end
  end
end
