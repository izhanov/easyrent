# frozen_string_literal: true

module Validations
  module Office
    module Consumables
      class Create < Base
        params do
          required(:car_id).filled(:integer)
          required(:title).filled(:string)
          required(:lifetime).filled(:integer)
          optional(:description).value(:string)
        end
      end
    end
  end
end
