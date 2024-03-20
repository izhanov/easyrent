# frozen_string_literal: true

module Operations
  module Office
    module Consumables
      class Create < Base
        def call(params, responsible)
          validated_params = yield validate(params)
          consumable = yield commit(validated_params.to_h, responsible)
          Success(consumable)
        end

        private

        def validate(params)
          validation = Validations::Office::Consumables::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, responsible)
          audit_as_user(responsible) do
            consumable = Consumable.create!(params)
            Success(consumable)
          end
        end
      end
    end
  end
end
