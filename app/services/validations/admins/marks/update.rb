# frozen_string_literal: true

module Validations
  module Admins
    module Marks
      class Update < Validations::Base
        params do
          required(:title).filled(:string)
          required(:body).filled(:string)
          optional(:synonyms).filled(array[:string])
        end
      end
    end
  end
end
