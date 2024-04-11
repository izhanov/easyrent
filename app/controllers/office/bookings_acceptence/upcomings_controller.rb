# frozen_string_literal: true

module Office
  module BookingsAcceptance
    class UpcomingsController < BaseController
      def index
        query = Utils::Typesense::Bookings::QueryBuilder.new(**query_params).call

        @q = Booking.typesense(query)
        relation = @current_office_user.bookings.nearest_to_give_out.where(id: @q.pluck(:id))

        @page, @bookings = pagy(relation)
      end


      private

      def query_params
        return params.require(:q).permit(:query, :car_park_id, :starts_at).to_h.deep_symbolize_keys if params[:q]

        {}
      end
    end
  end
end
