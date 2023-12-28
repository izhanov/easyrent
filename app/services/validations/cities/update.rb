# frozen_string_literal: true

module Validations
  module Cities
    class Update < Base
      params do
        required(:title).filled(:string)
        optional(:slug).value(:string)
      end

      rule(:slug) do
        key.failure(:invalid_format) unless value&.match?(/^[a-z]+(?:-[a-z]+)*$/)
      end
    end
  end
end
