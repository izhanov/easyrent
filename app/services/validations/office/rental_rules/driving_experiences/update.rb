# frozen_string_literal: true

module Validations
  module Office
    module RentalRules
      module DrivingExperiences
        class Update < Base
          params do
            required(:value).filled(:integer, gt?: 0)
          end
        end
      end
    end
  end
end
