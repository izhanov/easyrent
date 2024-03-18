# frozen_string_literal: true

module Operations
  module Office
    module Comments
      class Create < Base
        def call(params, responsible)
          validated_params = yield validate(params)
          comment = yield commit(validated_params.to_h, responsible)
          Success(comment)
        end

        private

        def validate(params)
          validation = Validations::Office::Comments::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, responsible)
          audit_as_user(responsible) do
            comment = Comment.create!(params)
            Success(comment)
          end
        end
      end
    end
  end
end
