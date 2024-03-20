# frozen_string_literal: true

module Office
  module ConsumablesHelper
    def localize_title(title)
      I18n.t("activerecord.attributes.consumable.titles.#{title}")
    end
  end
end
