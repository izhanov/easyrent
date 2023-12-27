# frozen_string_literal: true

module Validations
  module Marks
    class Create < Validations::Base
      params do
        required(:brand_id).filled(:integer)
        required(:title).filled(:string)
        required(:body).filled(:string)
        optional(:synonyms).value(array[:string])
      end

      rule(:title) do
        key.failure("has already been taken") if Mark.exists?(title: value)
      end
    end
  end
end
