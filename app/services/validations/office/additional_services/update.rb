# frozen_string_literal: true

module Validations
  module Office
    module AdditionalServices
      class Update < Base
        params do
          required(:title).filled(:string)
          required(:price).filled(:decimal, gt?: 0)
          optional(:kind).value(included_in?: AdditionalService::KINDS)
        end
      end
    end
  end
end
