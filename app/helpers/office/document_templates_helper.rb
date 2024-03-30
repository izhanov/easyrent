# frozen_string_literal: true

module Office
  module DocumentTemplatesHelper
    def localize_document_template_context(context)
      I18n.t("activerecord.attributes.document_template.contexts.#{context}")
    end
  end
end
