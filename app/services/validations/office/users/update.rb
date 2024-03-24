# frozen_string_literal: true

module Validations
  module Office
    module Users
      class Update < Base
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:phone).filled(:string)
        end
      end
    end
  end
end
