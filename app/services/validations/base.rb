# frozen_string_literal: true

module Validations
  class Base < Dry::Validation::Contract
    config.messages.backend = :i18n

    config.messages.load_paths << Rails.root.join("config/locales/errors/en.yml")
    config.messages.load_paths << Rails.root.join("config/locales/errors/ru.yml")

    register_macro(:phone_format) do
      key.failure(:invalid_format) unless value.match? Utils::Regexp::PHONE
    end
  end
end
