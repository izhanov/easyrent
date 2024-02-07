# frozen_string_literal: true

module Validations
  class Base < Dry::Validation::Contract
    config.messages.backend = :i18n

    config.messages.load_paths << Rails.root.join("config/locales/errors/en.yml")
    config.messages.load_paths << Rails.root.join("config/locales/errors/ru.yml")

    register_macro(:phone_format) do
      key.failure(:invalid_format) unless key? && value.match?(Utils::Regexp::PHONE)
    end

    register_macro(:bank_account_number_format) do
      key.failure(:invalid_format) unless key? && value.match?(/\AKZ[A-Z0-9]{18}\z/)
    end
  end
end
