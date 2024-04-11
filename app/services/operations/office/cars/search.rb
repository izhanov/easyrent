module Operations
  module Office
    module Cars
      class Search < Base
        attr_reader :car, :date_from, :date_to

        def initialize(
          car: nil,
          date_from: nil,
          date_to: nil
        )
          @car = car
          @date_from = date_from
          @date_to = date_to
        end

        # @return [Car::ActiveRecord_Relation]
        def call
          filter_by_date
          filter_by_car

          @cars
        end

        private

        def reserved_bookings
          @reserved ||= Booking.where(
            '(starts_at < ? AND ends_at >= ?) OR (starts_at <= ? AND ends_at > ?) OR (starts_at >= ? AND ends_at <= ?)',
            date_to,
            date_to,
            date_from,
            date_from,
            date_from,
            date_to
          ).where(
            status: %w[
              initial
              confirmed
              give_out_the_car
              start_the_rent
              end_the_rent
              accept_the_car
              return_the_deposit
            ]
          )
        end

        # @return [Car::ActiveRecord_Relation]
        def filter_by_date
          reserved_car_ids = reserved_bookings.pluck(:car_id)

          @cars = Car.where.not(
            id: reserved_car_ids, technical_condition: "under_repair"
          )

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
      end
    end
  end
end
