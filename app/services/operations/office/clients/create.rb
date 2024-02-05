# frozen_string_literal: true

module Operations
  module Office
    module Clients
      class Create < Base
        def call(params)
          kind = yield define_kind(params[:kind])
          validated_params = yield validate(kind, params)
          client = yield commit(validated_params.to_h)
          Success(client)
        end

        private

        def validate(kind, params)
          validation_klass = "Validations::Office::Clients::#{kind.capitalize}::Create".constantize
          validation = validation_klass.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          client = Client.create!(params)
          Success(client)
        rescue ActiveRecord::RecordNotUnique
          errors = {
            identification_or_phone_number: [
              I18n.t("dry_validation.errors.rules.client.identification_or_phone_number.uniqueness_violation")
            ]
          }

          Failure[
            :uniqueness_violation,
            errors
          ]
        end

        def define_kind(kind)
          Client::KINDS.include?(kind) ? Success(kind) : Failure[:invalid_kind, {kind: ["is invalid"]}]
        end
      end
    end
  end
end
