# frozen_string_literal: true

module Office
  module BookingsAcceptance
    class CompletedController < BaseController
      def index
        query = Utils::Typesense::Bookings::QueryBuilder.new(**query_params).call

        @q = Booking.typesense(query)
        relation = @current_office_user.bookings.by_status(["completed", "cancelled"]).where(id: @q.pluck(:id))

        @pagy, @bookings = pagy(relation, items: 10)
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
    end
  end
end
