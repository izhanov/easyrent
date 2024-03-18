# frozen_string_literal: true

module Validations
  module Office
    module Comments
      class Create < Base
        params do
          required(:commentable_id).filled(:integer)
          required(:commentable_type).filled(:string)
          required(:content).filled(:string)
        end
      end
    end
  end
end
