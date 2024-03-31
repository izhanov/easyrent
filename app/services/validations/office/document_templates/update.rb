# frozen_string_literal: true

module Validations
  module Office
    module DocumentTemplates
      class Update < Base
        params do
          required(:current).filled(:bool)
          required(:title).filled(:string)
          required(:content).filled(:string)
        end
      end
    end
  end
end
