# frozen_string_literal: true

module Operations
  module Office
    module Consumables
      class Destroy < Base
        def call(consumable, responsible)
          audit_as_user(responsible) do
            consumable.destroy!
            Success(true)
          end
        end
      end
    end
  end
end
