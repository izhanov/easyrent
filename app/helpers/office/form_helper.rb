# frozen_string_literal: true

module Office
  module FormHelper
    def error_field(errors, *field)
      if errors && errors.dig(*field).present?
        content_tag(:span, errors.dig(*field).first, class: "small text-danger error-field")
      end
    end
  end
end
