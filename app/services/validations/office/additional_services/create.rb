# frozen_string_literal: true

module Validations
  module Office
    module AdditionalServices
      class Create < Base
        params do
          required(:title).filled(:string)
          required(:price).filled(:decimal, gt?: 0)
          required(:owner_type).filled(:string)
          required(:owner_id).filled(:integer)
        end
      end
    end
  end
end
