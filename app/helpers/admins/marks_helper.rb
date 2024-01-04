# frozen_string_literal: true

module Admins
  module MarksHelper
    def localize_body_type(body_type)
      I18n.t("activerecord.attributes.mark.bodies.#{body_type}")
    end
  end
end
