# frozen_string_literal: true

module Office
  class ConsumablesController < BaseController
    before_action :find_car, :find_car_park
    before_action :find_consumable, only: %i[show edit update destroy]

    helper ConsumablesHelper

    def index
      @consumables = @car.consumables
    end

    def new
      @consumable = @car.consumables.new
    end

    def create
      operation = Operations::Office::Consumables::Create.new
      result = operation.call(consumable_params.to_h, current_office_user)

      case result
      in Success[consumable]
        @consumable = consumable
        respond_to do |format|
          format.html { redirect_to office_car_park_car_consumable_path(@car_park, @car, @consumable) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @consumable = @car.consumables.new(consumable_params)
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Office::Consumables::Update.new
      result = operation.call(@consumable, consumable_params.to_h, current_office_user)

      case result
      in Success[consumable]
        redirect_to office_car_park_car_consumable_path(@car_park, @car, consumable)
      in Failure[error_code, errors]
        @consumable = @car.consumables.new(consumable_params)
        render :edit
      end
    end

    def destroy
      operation = Operations::Office::Consumables::Destroy.new
      result = operation.call(@consumable, current_office_user)

      case result
      in Success
        redirect_to office_car_park_car_consumables_path(@car_park, @car)
      in Failure[error_code, errors]
        redirect_to office_car_park_car_consumable_path(@car_park, @car, @consumable)
      end
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def find_consumable
      @consumable = @car.consumables.find(params[:id])
    end

    def consumable_params
      params.require(:consumable).permit(:car_id, :title, :description, :lifetime)
    end
  end
end
