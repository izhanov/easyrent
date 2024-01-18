# frozen_string_literal: true

module Office
  module FormHelper
    def error_field(errors, field)
      if errors && errors[field].present?
        content_tag(:span, errors[field].first, class: "small text-danger error-field")
      end
    end
  end
end
