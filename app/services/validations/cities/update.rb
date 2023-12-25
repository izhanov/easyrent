# frozen_string_literal: true

module Validations
  module Cities
    class Update < Base
      params do
        optional(:title).filled(:string)
        optional(:slug).filled(:string)
      end
    end
  end
end
