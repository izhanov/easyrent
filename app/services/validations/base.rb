# frozen_string_literal: true

module Validations
  class Base < Dry::Validation::Contract
    config.messages.backend = :yaml
    config.messages.load_paths << "config/locales/errors/en.yml"
    config.messages.load_paths << "config/locales/errors/ru.yml"
  end
end
