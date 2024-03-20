# frozen_string_literal: true

module Validations
  module Office
    module Consumables
      class Update < Base
        params do
          required(:title).filled(:string)
          required(:lifetime).filled(:integer)
          optional(:description).value(:string)
        end
      end
    end
  end
end
