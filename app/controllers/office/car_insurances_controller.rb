# frozen_string_literal: true

module Office
  class CarInsurancesController < BaseController
    before_action :find_car
    before_action :find_car_park

    helper Office::CarInsurancesHelper

    def index
      @car_insurances = @car.insurances.order(id: :desc)
    end

    def new
      @car_insurance = CarInsurance.new
    end

    def create
      operation = Operations::Office::CarInsurances::Create.new
      result = operation.call(@car, car_insurance_params.to_h, current_office_user)

      case result
      in Success[car_insurance]
        @car_insurance = car_insurance
        respond_to do |format|
          format.html { redirect_to office_car_park_car_car_insurances_path(@car_park, @car) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @car_insurance = CarInsurance.new(car_insurance_params.to_h)
        render :new
      end
    end

    def show
      @car_insurance = @car.insurances.find(params[:id])
    end

    def edit
      @car_insurance = @car.insurances.find(params[:id])
    end

    def update
      @car_insurance = @car.insurances.find(params[:id])
      operation = Operations::Office::CarInsurances::Update.new
      result = operation.call(@car_insurance, car_insurance_params.to_h, current_office_user)

      case result
      in Success[car_insurance]
        respond_to do |format|
          format.html { redirect_to office_car_park_car_car_insurances_path(@car_park, @car) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @car_insurance = CarInsurance.new(car_insurance_params.to_h)
        render :edit
      end
    end

    def destroy
      @car_insurance = @car.insurances.find(params[:id])
      @car_insurance.destroy!
      respond_to do |format|
        format.html { redirect_to office_car_park_car_car_insurances_path(@car_park, @car) }
        format.turbo_stream
      end
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def car_insurance_params
      params.require(:car_insurance).permit(:start_at, :end_at, :kind, :car_id)
    end
  end
end
