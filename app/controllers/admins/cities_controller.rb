# frozen_string_literal: true

module Admins
  class CitiesController < BaseController
    before_action :find_city, only: %i[show edit update destroy]

    def index
      @cities = City.all
    end

    def new
      @city = City.new
    end

    def create
      operation = Operations::Admins::Cities::Create.new

      result = operation.call(city_params.to_h)

      case result
      in Success[city]
        redirect_to admins_cities_path, flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @city = City.new(city_params)
        @errors = errors
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Admins::Cities::Update.new

      result = operation.call(@city, city_params.to_h)

      case result
      in Success[city]
        redirect_to admins_city_path(@city), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @city.destroy!
      redirect_to admins_cities_path, flash: {success: success_resolver(path: "cities.destroy")}
    end

    private

    def city_params
      params.require(:city).permit(:title, :slug)
    end

    def find_city
      @city = City.find(params[:id])
    end
  end
end
