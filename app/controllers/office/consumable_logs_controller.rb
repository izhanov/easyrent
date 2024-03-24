# frozen_string_literal: true

module Office
  class ConsumableLogsController < BaseController
    before_action :find_car, :find_car_park, :find_consumable
    before_action :find_consumable_log, only: %i[show edit update destroy]

    def new
      @consumable_log = @consumable.consumable_logs.new
    end

    def create
      operation = Operations::Office::ConsumableLogs::Create.new
      result = operation.call(consumable_log_params.to_h, current_office_user)

      case result
      in Success[consumable_log]
        @consumable_log = consumable_log
        respond_to do |format|
          format.html { redirect_to office_car_park_car_consumable_path(@car_park, @car, @consumable) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @consumable_log = @consumable.consumable_logs.new(consumable_log_params)
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Office::ConsumableLogs::Update.new
      result = operation.call(@consumable_log, consumable_log_params.to_h, current_office_user)

      case result
      in Success[consumable_log]
        redirect_to office_car_park_car_consumable_path(@car_park, @car, @consumable)
      in Failure[error_code, errors]
        @consumable_log = @consumable.consumable_logs.new(consumable_log_params)
        render :edit
      end
    end

    def destroy
      operation = Operations::Office::ConsumableLogs::Destroy.new
      result = operation.call(@consumable_log, current_office_user)

      case result
      in Success
        respond_to do |format|
          format.html { redirect_to office_car_park_car_consumable_path(@car_park, @car, @consumable) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
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
      @consumable = @car.consumables.find(params[:consumable_id])
    end

    def find_consumable_log
      @consumable_log = @consumable.consumable_logs.find(params[:id])
    end

    def consumable_log_params
      params.require(:consumable_log).permit(
        :consumable_id,
        :mileage_when_replacing,
        :mileage_at_next_replacing,
        :date,
        :description
      )
    end
  end
end
