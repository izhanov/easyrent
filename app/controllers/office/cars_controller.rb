# frozen_string_literal: true

module Office
  class CarsController < BaseController
    before_action :find_car, only: %i[show edit update destroy]

    def index
    end

    def new
      @car = Car.new
    end

    def create
      operation = Operations::Office::Cars::Create.new
      result = operation.call(car_params.to_h)

      case result
      in Success[car]
        redirect_to office_user_car_path(current_office_user, car), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @car = Car.new(car_params)
        @errors = errors
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Office::Cars::Update.new
      result = operation.call(@car, car_params.to_h)

      case result
      in Success[car]
        redirect_to office_user_car_path(current_office_user, car), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @car = Car.new(car_params)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @car.destroy!
      redirect_to office_user_cars_path(current_office_user), flash: {success: t("office.cars.destroy.success")}
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:id])
    end
  end
end
