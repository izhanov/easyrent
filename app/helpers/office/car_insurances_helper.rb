# frozen_string_literal: true

module Office
  module CarInsurancesHelper
    def localize_car_insurance_kind(kind)
      I18n.t("activerecord.attributes.car_insurance.kinds.#{kind}")
    end
  end
end
