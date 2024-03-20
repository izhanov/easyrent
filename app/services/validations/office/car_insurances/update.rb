# frozen_string_literal: true

module Validations
  module Office
    module CarInsurances
      class Update < Base
        params do
          required(:car_id).filled(:integer)
          required(:start_at).filled(:date)
          required(:end_at).filled(:date)
          required(:kind).filled(:string)
        end
      end
    end
  end
end
