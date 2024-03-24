# frozen_string_literal: true

module Operations
  module Office
    module ConsumableLogs
      class Update < Base
        def call(consumable_log, params, responsible)
          validated_params = yield validate(params)
          updated_consumable = yield commit(consumable_log, validated_params.to_h, responsible)
          Success(updated_consumable)
        end

        private

        def validate(params)
          validation = Validations::Office::ConsumableLogs::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(consumable, params, responsible)
          audit_as_user(responsible) do
            consumable.update!(params)
            Success(consumable.reload)
          end
        end
      end
    end
  end
end
