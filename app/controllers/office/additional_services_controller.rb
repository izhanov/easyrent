# frozen_string_literal: true

module Office
  class AdditionalServicesController < BaseController
    before_action :find_car_park
    before_action :find_additional_service, only: %i[show edit update destroy]

    def index
      @additional_services = @car_park.additional_services
    end

    def new
      @additional_service = AdditionalService.new
    end

    def show
      @additional_service = @car_park.additional_services.find(params[:id])
    end

    def create
      operation = Operations::Office::AdditionalServices::Create.new
      result = operation.call(additional_service_params.to_h)

      case result
      in Success[additional_service]
        @additional_service = additional_service

        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @additional_service = AdditionalService.new(additional_service_params.to_h)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      operation = Operations::Office::AdditionalServices::Update.new
      result = operation.call(@additional_service, additional_service_params.to_h)
      puts result
      case result
      in Success[additional_service]
        @additional_service = additional_service

        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @additional_service = AdditionalService.new(additional_service_params.to_h)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @additional_service.destroy!
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      end
    end

    def booking_checkboxes
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
      render partial: "booking_checkboxes", locals: { car_park: @car_park }
    end

    private

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def find_additional_service
      @additional_service = @car_park.additional_services.find(params[:id])
    end

    def additional_service_params
      params.require(:additional_service).permit(:title, :price, :slug, :owner_id, :owner_type)
    end
  end
end
