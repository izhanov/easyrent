# frozen_string_literal: true

module Admins
  class MarksController < BaseController
    before_action :find_mark, only: %i[show edit update destroy]

    helper Admins::MarksHelper

    def index
      @marks = Mark.all
    end

    def new
      @mark = Mark.new
    end

    def create
      operation = Operations::Admins::Marks::Create.new

      result = operation.call(normalize_marks_synonyms(mark_params.to_h))

      case result
      in Success[mark]
        redirect_to admins_mark_path(mark), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:danger] = failure_resolver(operation, error_code: error_code)
        @mark = Mark.new(mark_params)
        @errors = errors
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Admins::Marks::Update.new
      result = operation.call(@mark, normalize_marks_synonyms(mark_params.to_h))

      case result
      in Success[mark]
        redirect_to admins_mark_path(@mark), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @mark.destroy!
      redirect_to admins_marks_path, flash: {success: success_resolver(path: "marks.destroy")}
    end

    private

    def mark_params
      params.require(:mark).permit(:title, :brand_id, :body, synonyms: [])
    end

    def find_mark
      @mark = Mark.find(params[:id])
    end

    def normalize_marks_synonyms(params)
      params["synonyms"] =
        params["synonyms"].map { |syn| syn.split(",") }.flatten

      params["synonyms"] =
        params["synonyms"].map { |syn|
          syn.gsub(%r{[^a-zA-ZА-Яа-я\d\s]}, "").strip
        }.reject(&:blank?)

      params
    end
  end
end
