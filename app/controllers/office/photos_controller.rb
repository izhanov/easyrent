# frozen_string_literal: true

module Office
  class PhotosController < BaseController
    before_action :find_car, :find_car_park

    def index
      @photos = @car.photos
    end

    private

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end
  end
end
