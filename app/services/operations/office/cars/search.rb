module Operations
  module Office
    module Cars
      class Search < Base
        attr_reader :car, :starts_at, :ends_at

        def initialize(
          car: nil,
          starts_at: nil,
          ends_at: nil
        )
          @car = car
          @starts_at = starts_at
          @ends_at = ends_at
        end

        # @return [Car::ActiveRecord_Relation]
        def call
          filter_by_date
          filter_by_car

          @cars
        end

        private

        def reserved_bookings
          @reserved ||= Booking.left_joins(:car).where(
            bookings_table.grouping(
              bookings_table[:starts_at].between(starts_at..ends_at).or(
                bookings_table[:ends_at].between(starts_at..ends_at)
              ).or(
                bookings_table[:starts_at].lt(starts_at).and(bookings_table[:ends_at].gt(ends_at))
              )
            ).and(
              bookings_table[:status].not_in(["completed", "cancelled"])
            )
          )
        end

        # @return [Car::ActiveRecord_Relation]
        def filter_by_date
          reserved_car_ids = reserved_bookings.pluck(:car_id)

          @cars = Car.where.not(id: reserved_car_ids).where.not(technical_condition: "under_repair")

          @cars
        end

        def filter_by_car
          return @cars if car.blank?

          @cars = @cars.joins(mark: :brand)
            .where(
              'brands.title ILIKE :search OR marks.title ILIKE :search OR marks.body ILIKE :search OR cars.plate_number ILIKE :search',
              search: "%#{car}%"
            )
        end

        def bookings_table
          Booking.arel_table
        end

        def cars_table
          Car.arel_table
        end
      end
    end
  end
end
