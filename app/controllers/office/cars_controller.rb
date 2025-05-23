# frozen_string_literal: true

module Office
  class CarsController < BaseController
    before_action :find_car, only: %i[show edit update destroy]
    before_action :find_car_park

    helper CarsHelper

    def index
      @cars = current_office_user.cars
    end

    def new
      @car = Car.new
      @car_inspection = @car.car_inspections.build
      @car_insurance = @car.insurances.build
      @photo = @car.photos.build
    end

    # TODO: MEEH! Must be refactored
    def create
      operation = Operations::Office::Cars::Create.new
      result = operation.call(
        car_params.to_h.merge(
          photos_attributes: photos_attributes_params,
          insurances_attributes: insurances_attributes_params,
          car_inspections_attributes: car_inspections_attributes_params
        )
      )

      case result
      in Success[car]
        success_message = {success: success_resolver(operation)}
        redirect_to office_car_park_car_path(@car_park, car), flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        # TODO: Move photo uploading to a separate page
        @car = Car.new(car_params.merge(photos_attributes: {}))
        @car_inspection = CarInspection.new(car_inspections_attributes_params)
        @car_insurance = CarInsurance.new(insurances_attributes_params)
        @errors = errors
        render :new
      end
    end

    def show
    end

    def edit
      @car_inspection = @car.car_inspections.active.last || @car.car_inspections.build
      @car_insurance = @car.insurances.active.last || @car.insurances.build
    end

    def update
      operation = Operations::Office::Cars::Update.new
      result = operation.call(
        @car,
        car_params.to_h.merge(
          photos_attributes: photos_attributes_params,
          insurances_attributes: insurances_attributes_params.merge(car_id: @car.id),
          car_inspections_attributes: car_inspections_attributes_params.merge(car_id: @car.id)
        )
      )

      case result
      in Success[car]
        success_message = {success: success_resolver(operation)}
        redirect_to office_car_park_car_path(@car_park, car), flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        @car_inspection = CarInspection.new(car_inspections_attributes_params)
        @car_insurance = CarInsurance.new(insurances_attributes_params)
        @car.assign_attributes(car_params)
        render :edit
      end
    end

    def destroy
      @car.destroy!
      flash[:success] = success_resolver(path: "cars.destroy")
      redirect_to office_car_park_path(@car_park), status: :see_other
    end

    def search
      @q = Car.typesense(
        q: params[:q],
        query_by: "plate_number, mark.title, color, vin_code, klass, mark.synonyms",
        infix: "always, always, always, always, always, always",
      )
      @cars = @car_park.cars.where(id: @q.pluck(:id))
      render partial: "office/cars/search", locals: {cars: @cars}
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def car_params
      params.require(:car).permit(
        :owner_id,
        :owner_type,
        :mark_id,
        :vin_code,
        :year,
        :color,
        :status,
        :plate_number,
        :klass,
        :fuel,
        :engine_capacity,
        :engine_capacity_unit,
        :mileage,
        :number_of_seats,
        :tank_volume,
        :technical_certificate_number,
        :transmission,
        :technical_condition,
        :appearance,
        :over_mileage_price,
        photos_attributes: [
          image: []
        ],
        insurances_attributes: [:start_at, :end_at, :kind],
        car_inspections_attributes: [:start_at, :end_at]
      )
    end

    # TODO: Should be moved to separate operation
    # TODO: with the separate validation
    # TODO: and the different page for the photos upload
    # This method is used to convert the params to the format that the operation expects
    # The operation expects the photos_attributes to be in the format of:
    # {
    #   0: {image_data: "base64"},
    #   1: {image_data: "base64"},
    # }
    def photos_attributes_params
      car_params[:photos_attributes].to_h.each_with_object({}) do |(_, images_attributes), attributes|
        images_attributes.each do |_, images|
          images.each_with_index do |image, index|
            attributes[index] = {image: image}
          end
        end
      end
    end

    def insurances_attributes_params
      car_params[:insurances_attributes].to_h.each_with_object({}) do |(_, insurance_attributes), attributes|
        attributes.merge!(insurance_attributes)
      end
    end

    def car_inspections_attributes_params
      car_params[:car_inspections_attributes].to_h.each_with_object({}) do |(_, car_inspection_attributes), attributes|
        attributes.merge!(car_inspection_attributes)
      end
    end
  end
end
