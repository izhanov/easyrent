# frozen_string_literal: true

module Operations
  module Office
    module ConsumableLogs
      class Create < Base
        def call(params, responsible)
          validated_params = yield validate(params)
          consumable = yield commit(validated_params.to_h, responsible)
          Success(consumable)
        end

        private

        def validate(params)
          validation = Validations::Office::ConsumableLogs::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, responsible)
          audit_as_user(responsible) do
            consumable = ConsumableLog.create!(params)
            Success(consumable)
          end
        end
      end
    end
  end
end
