# frozen_string_literal: true

module Office
  module BookingsAcceptance
    class UpcomingsController < BaseController
      def index
        query = Utils::Typesense::Bookings::QueryBuilder.new(**query_params).call

        @q = Booking.typesense(query)
        relation = @current_office_user.bookings.nearest_to_accept.where(id: @q.pluck(:id))

        @pagy, @bookings = pagy(relation)
      end

      def show
      end

      def update
        operation = Operations::Office::BookingsAcceptance::AcceptTheCar.new
        result = operation.call(accept_params.merge(car_params), @booking, current_office_user)

        case result
        in Success
          flash[:success] = success_resolver(operation)
          redirect_to office_bookings_acceptance_completed_path(@booking)
        in Failure[error_code, errors]
          flash.now[:error] = failure_resolver(operation, error_code: error_code)
          @errors = errors
          render :show
        end
      end

      private

      def query_params
        if params[:q]
          return params.require(:q).permit(
            :query,
            :car_park_id,
            :starts_at,
            :ends_at
          ).to_h.deep_symbolize_keys
        end

        {}
      end

      def find_booking
        @booking = Booking.find(params[:id])
      end

      def accept_params
        params.require(:booking).permit(
          :actual_ends_at,
          :drop_off_location,
          :mileage_after_rent,
          :fuel_level_after_rent,
          :appearance_after_rent,
          :technical_condition_after_rent
        )
      end
    end
  end
end
