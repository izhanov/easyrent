# frozen_string_literal: true

module Office
  class CarParksController < BaseController
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
        redirect_to office_user_car_park_path(current_office_user, car_park), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @car_park = CarPark.new(car_park_params)
        @errors = errors
        render :new
      end
    end

    private

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
        :service_phone
      )
    end
  end
end
