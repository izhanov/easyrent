# frozen_string_literal: true

module ArelHelpers
  module Cars
    extend ActiveSupport::Concern
    include Arel::FactoryMethods

    # left join bookings on car_id

    class_methods do
      def bookings_on_certain_car_id_left_join(id)
        arel_table.create_join(
          Booking.arel_table,
          arel_table.create_on(
            Booking.arel_table[:car_id].eq(id)
          ),
          Arel::Nodes::OuterJoin
        )
      end
    end
  end
end
