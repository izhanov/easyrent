# frozen_string_literal: true

module Operations
  module Office
    module DocumentTemplates
      class Update < Base
        def call(document_template, params, responsible)
          validated_params = yield validate(params)
          updated_document_template = yield commit(document_template, validated_params.to_h, responsible)
          Success(updated_document_template)
        end

        private

        def validate(params)
          validation = Validations::Office::DocumentTemplates::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(document_template, params, responsible)
          audit_as_user(responsible) do
            document_template.update!(params)
            Success(document_template)
          end
        end
      end
    end
  end
end
