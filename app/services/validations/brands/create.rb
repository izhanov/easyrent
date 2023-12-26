# frozen_string_literal: true

module Validations
  module Brands
    class Create < Base
      params do
        required(:title).filled(:string)
        optional(:synonyms).value(array[:string])
      end

      rule(:title) do
        key.failure("must be unique") if Brand.find_by(title: value)
      end
    end
  end
end
