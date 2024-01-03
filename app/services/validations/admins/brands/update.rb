# frozen_string_literal: true

module Validations
  module Admins
    module Brands
      class Update < Base
        params do
          required(:title).filled(:string)
          optional(:synonyms).value(array[:string])
        end
      end
    end
  end
end
