# frozen_string_literal: true

module Validations
  module Admins
    module Marks
      class Create < Validations::Base
        params do
          required(:brand_id).filled(:integer)
          required(:title).filled(:string)
          required(:body).filled(:string)
          optional(:synonyms).value(array[:string])
        end
      end
    end
  end
end
