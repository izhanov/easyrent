# frozen_string_literal: true

module Office
  class PriceRangesController < BaseController
    before_action :find_car_park

    def new
      @price_range = @car_park.price_range
    end

    def show
      @price_range = @car_park.price_range
    end

    def update
      render json: {status: params[:price_range][:unit]}
    end

    private

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end
  end
end
