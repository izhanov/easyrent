# frozen_string_literal: true

module Validations
  module Office
    module CarInsurances
      class Create < Base
        params do
          required(:start_at).filled(:date)
          required(:end_at).filled(:date)
          required(:kind).filled(:string)
        end

        rule(:start_at, :end_at) do

        end
      end
    end
  end
end
