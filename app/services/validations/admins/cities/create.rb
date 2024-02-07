# frozen_string_literal: true

module Validations
  module Admins
    module Cities
      class Create < Base
        params do
          required(:title).filled(:string)
          optional(:slug).value(:string)
        end

        rule(:slug) do
          if value.present?
            key.failure(:invalid_format) unless value&.match?(/^[a-z]+(?:-[a-z]+)*$/)
          end
        end
      end
    end
  end
end
