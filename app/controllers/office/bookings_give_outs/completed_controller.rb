# frozen_string_literal: true

module Office
  module BookingsGiveOuts
    class CompletedController < BaseController
      def index
        query = Utils::Typesense::Bookings::QueryBuilder.new(**query_params).call
        @q = Booking.typesense(query)
        relation = @current_office_user.bookings.by_status(:start_the_rent).where(id: @q.pluck(:id))
        @page, @bookings = pagy(relation, items: 10)
      end

      def show
        @booking = Booking.find(params[:id])
      end

      private

      def query_params
        return params.require(:q).permit(:query, :car_park_id, :starts_at, :ends_at).to_h.deep_symbolize_keys if params[:q]

        {}
      end
    end
  end
end
