# frozen_string_literal: true

module Operations
  module Office
    module Clients
      class Update < Base
        def call(client, params)
          kind = yield define_kind(params[:kind])
          validated_params = yield validate(kind, params)
          updated_client = yield commit(client, validated_params.to_h)
          Success(updated_client)
        end

        private

        def validate(kind, params)
          validation_klass = "Validations::Office::Clients::#{kind.capitalize}::Update".constantize
          validation = validation_klass.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(client, params)
          client.update!(params)
          Success(client.reload)
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
