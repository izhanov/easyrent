# frozen_string_literal: true

module Validations
  module Office
    module CarInspections
      class Create < Base
        params do
          required(:start_at).filled(:date)
          required(:end_at).filled(:date)
        end
      end
    end
  end
end
