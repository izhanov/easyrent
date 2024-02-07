# frozen_string_literal: true

module Office
  class MarksController < BaseController
    def search
      @q = Mark.typesense(
        q: params[:q],
        query_by: "brand.title, title, synonyms, brand.synonyms",
        infix: "always, false"
      )
      @marks = Mark.where(id: @q.pluck(:id))
      render partial: "office/marks/search", locals: {marks: @marks}
    end
  end
end
