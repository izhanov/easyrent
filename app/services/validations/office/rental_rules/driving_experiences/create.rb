# frozen_string_literal: true

module Validations
  module Office
    module RentalRules
      module DrivingExperiences
        class Create < Base
          params do
            required(:value).filled(:integer, gt?: 0)
            required(:owner_id).filled(:integer)
            required(:owner_type).filled(:string)
          end
        end
      end
    end
  end
end
