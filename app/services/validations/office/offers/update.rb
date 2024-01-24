# frozen_string_literal: true

module Validations
  module Office
    module Offers
      class Update < Base
        params do
          required(:car_id).filled(:integer)
          required(:title).filled(:string, max_size?: 20)
          required(:prices).filled(:hash)
          required(:services).filled(:hash)
        end
      end
    end
  end
end
