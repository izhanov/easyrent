# frozen_string_literal: true

module Operations
  module Office
    module DocumentTemplates
      class Create < Base
        def call(params, responsible)
          validated_params = yield validate(params)
          document_template = yield commit(validated_params.to_h, responsible)
          Success(document_template)
        end

        private

        def validate(params)
          validation = Validations::Office::DocumentTemplates::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params, responsible)
          ActiveRecord::Base.transaction do
            audit_as_user(responsible) do
              if params[:current] && params[:context] == "contract"
                existing_document_template = responsible.document_templates.current_for(params[:context])
                existing_document_template&.update!(current: false)
              end
              document_template = DocumentTemplate.create!(params)
              Success(document_template)
            end
          end
        end
      end
    end
  end
end
