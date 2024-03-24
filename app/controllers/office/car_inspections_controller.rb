# frozen_string_literal: true

module Office
  class CarInspectionsController < BaseController
    before_action :find_car, :find_car_park
    before_action :find_car_inspection, only: %i[show edit update destroy]

    def index
      @car_inspections = @car.car_inspections
    end

    def new
      @car_inspection = CarInspection.new
    end

    def create
      operation = Operations::Office::CarInspections::Create.new
      result = operation.call(@car, car_inspection_params.to_h, current_office_user)

      case result
      in Success[car_inspection]
        @car_inspection = car_inspection
        respond_to do |format|
          format.html { redirect_to office_car_park_car_car_inspections_path(@car_park, @car) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        @car_inspection = CarInspection.new(car_inspection_params)
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Office::CarInspections::Update.new
      result = operation.call(@car_inspection, car_inspection_params.to_h, current_office_user)

      case result
      in Success[car_inspection]
        success_message = {success: success_resolver(operation)}
        redirect_to office_car_park_car_car_inspections_path(@car_park, @car), flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      operation = Operations::Office::CarInspections::Destroy.new
      result = operation.call(@car_inspection)

      case result
      in Success
        success_message = {success: success_resolver(operation)}
        respond_to do |format|
          format.html { redirect_to office_car_park_car_car_inspections_path(@car_park, @car), flash: success_message }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :show
      end
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def find_car_inspection
      @car_inspection = @car.car_inspections.find(params[:id])
    end

    def car_inspection_params
      params.require(:car_inspection).permit(:car_id, :start_at, :end_at)
    end
  end
end
