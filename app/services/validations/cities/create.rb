# frozen_string_literal: true

module Validations
  module Cities
    class Create < Base
      params do
        required(:title).filled(:string)
        optional(:slug).value(:string)
      end
    end
  end
end
