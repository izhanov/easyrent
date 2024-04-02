# frozen_string_literal: true

module Office
  module DocumentTemplatesHelper
    def localize_document_template_context(context)
      I18n.t("activerecord.attributes.document_template.contexts.#{context}")
    end

    def localize_document_template_kind(kind)
      I18n.t("activerecord.attributes.document_template.kinds.#{kind}")
    end
  end
end
