# frozen_string_literal: true

module Validations
  module Office
    module DocumentTemplates
      class Create < Base
        params do
          required(:current).filled(:bool)
          required(:owner_id).filled(:integer)
          required(:owner_type).filled(:string)
          required(:title).filled(:string)
          required(:context).filled(:string)
          required(:content).filled(:string)
        end
      end
    end
  end
end
