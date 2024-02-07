# frozen_string_literal: true

module Office
  module CarsHelper
    def localize_fuel_type(fuel_type)
      I18n.t("activerecord.attributes.car.fuel_types.#{fuel_type}")
    end

    def localize_klass_type(klass_type)
      I18n.t("activerecord.attributes.car.klass_types.#{klass_type}")
    end

    def localize_transmission_type(transmission_type)
      I18n.t("activerecord.attributes.car.transmission_types.#{transmission_type}")
    end
  end
end
