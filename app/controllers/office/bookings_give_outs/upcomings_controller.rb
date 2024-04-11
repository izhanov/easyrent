# frozen_string_literal: true

module Office
  module BookingsGiveOuts
    class UpcomingsController < BaseController
      before_action :find_booking, only: %i[show update]

      helper Office::CarsHelper

      def index
        query = Utils::Typesense::Bookings::QueryBuilder.new(**query_params).call
        @q = Booking.typesense(query)
        relation = @current_office_user.bookings.nearest_to_give_out.where(id: @q.pluck(:id))
        @page, @bookings = pagy(relation, items: 10)
      end

      def show
        @booking = Booking.find(params[:id])
      end

      def update
        operation = Operations::Office::BookingsGiveOuts::GiveOutTheCar.new
        result = operation.call(give_out_params.merge(car_params), @booking, current_office_user)

        case result
        in Success
          flash[:success] = success_resolver(operation)
          redirect_to office_bookings_give_outs_completed_path(@booking)
        in Failure[error_code, errors]
          flash.now[:alert] = failure_resolver(operation, error_code:)
          @errors = errors
          render :show
        end
      end

      private

      def query_params
        return params.require(:q).permit(:query, :car_park_id, :starts_at).to_h.deep_symbolize_keys if params[:q]

        {}
      end

      def give_out_params
        params.require(:booking).permit(:actual_starts_at, :actual_ends_at, :pickup_location)
      end

      def car_params
        params.require(:car).permit(:mileage_before_rent, :fuel_level_before_rent, :appearance_before_rent, :technical_condition_before_rent)
      end

      def find_booking
        @booking = Booking.find(params[:id])
      end
    end
  end
end
