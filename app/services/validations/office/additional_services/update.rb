# frozen_string_literal: true

module Validations
  module Office
    module AdditionalServices
      class Update < Base
        params do
          required(:title).filled(:string)
          required(:price).filled(:decimal, gt?: 0)
          required(:slug).filled(:string)
        end
      end
    end
  end
end
