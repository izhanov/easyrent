# frozen_string_literal: true

module Admins
  class BrandsController < BaseController
    before_action :find_brand, only: %i[show edit update destroy]

    def index
      @brands = Brand.all
    end

    def new
      @brand = Brand.new
    end

    def create
      operation = Operations::Admins::Brands::Create.new
      result = operation.call(normalize_brands_synonyms(brand_params.to_h))

      case result
      in Success[brand]
        redirect_to admins_brands_path, flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash[:error] = failure_resolver(operation, error_code: error_code)
        @brand = Brand.new(brand_params)
        @errors = errors
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Admins::Brands::Update.new
      result = operation.call(
        @brand,
        normalize_brands_synonyms(brand_params.to_h)
      )

      case result
      in Success[brand]
        redirect_to admins_brand_path(brand), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @brand.destroy!
      redirect_to admins_brands_path, flash: {success: success_resolver(path: "brands.destroy")}
    end

    private

    def brand_params
      params.require(:brand).permit(:title, synonyms: [])
    end

    def find_brand
      @brand = Brand.find(params[:id])
    end

    def normalize_brands_synonyms(params)
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
