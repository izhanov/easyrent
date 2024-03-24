# frozen_string_literal: true

module Office
  class CarParksController < BaseController
    before_action :find_car_park, only: %i[show edit update destroy settings]

    def index
      @car_parks = current_office_user.car_parks
    end

    def new
      @car_park = CarPark.new
    end

    def create
      operation = Operations::Office::CarParks::Create.new
      result = operation.call(car_park_params.to_h)

      case result
      in Success[car_park]
        @car_park = car_park
        respond_to do |format|
          format.html { redirect_to office_car_park_path(car_park), flash: {success: success_resolver(operation)} }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @car_park = CarPark.new(car_park_params)
        @errors = errors
        render :new
      end
    end

    def show
      @pagy, @cars = pagy(@car_park.cars.order(:id), items: 10)
    end

    def edit
    end

    def settings
    end

    def update
      operation = Operations::Office::CarParks::Update.new
      result = operation.call(@car_park, car_park_params.to_h)

      case result
      in Success[car_park]
        redirect_to edit_office_car_park_path(car_park), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @car_park.destroy!
      redirect_to office_car_parks_path, flash: {success: success_resolver(path: "car_parks.destroy")}
    end

    private

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:id])
    end

    def car_park_params
      params.require(:car_park).permit(
        :user_id,
        :city_id,
        :title,
        :business_id_number,
        :legal_address,
        :kind,
        :contact_phone,
        :bank_name,
        :bank_account_number,
        :card_id_number,
        :privateer_number,
        :privateer_date,
        :residence_address,
        :bank_code,
        :benificiary_code,
        :email,
        :service_phone,
        :booking_prefix
      )
    end
  end
end
