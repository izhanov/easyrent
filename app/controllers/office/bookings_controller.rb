# frozen_string_literal: true

module Office
  class BookingsController < BaseController
    before_action :find_car_park, only: %i[create]
    before_action :find_booking, only: %i[show edit update destroy change_status]

    helper CarsHelper

    def index
      @bookings = current_office_user.bookings.left_joins(:car, :client, :offer).group_by(&:status)
    end

    def new
      @car = Car.find_by(id: params[:car_id]) || Car.new
      @car_park = @car.owner || current_office_user.car_parks.first

      @booking = Booking.new
    end

    def create
      operation = Operations::Office::Bookings::Create.new
      result = operation.call(booking_params.to_h, current_office_user)

      case result
      in Success[booking]
        Operations::Office::Bookings::Confirm.new.call(booking, current_office_user)

        respond_to do |format|
          format.js { render json: {booking: booking}, status: :created }
        end
      in Failure[error_code, errors]
        respond_to do |format|
          format.js { render json: {errors: errors}, status: :unprocessable_entity }
        end
      end
    end

    def show
    end

    def edit
    end

    def update
      operation = Operations::Office::Bookings::Update.new
      result = operation.call(@booking, booking_params.to_h, current_office_user)

      case result
      in Success[booking]
        success_message = {success: success_resolver(operation)}
        redirect_to office_booking_path(booking), flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    def destroy
      @booking.destroy!
      flash[:success] = success_resolver(path: "bookings.destroy")
      redirect_to office_bookings_path, status: :see_other
    end

    def change_status
      operation = Operations::Office::Bookings::ChangeStatus.new
      result = operation.call(@booking, params[:booking][:status], current_office_user)

      case result
      in Success[booking]
        success_message = {success: success_resolver(operation)}
        redirect_to office_booking_path(booking), flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    private

    def booking_params
      params.require(:booking).permit(
        :car_id,
        :client_id,
        :offer_id,
        :starts_at,
        :ends_at,
        :self_pickup,
        :self_drop_off,
        :pickup_location,
        :drop_off_location,
        :car,
        :client,
        :payment_method,
        :with_pledge_amount,
        :pledge_amount,
        :pledge_method,
        :without_prepayment_amount,
        :prepayment_amount,
        :prepayment_method,
        :kaspi_method_amount,
        :halyk_method_amount,
        :cash_method_amount,
        comments_attributes: %i[content],
        services: {}
      )
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def find_booking
      @booking = current_office_user.bookings.find(params[:id])
    end
  end
end
