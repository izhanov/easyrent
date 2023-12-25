# frozen_string_literal: true

module Admins
  class CarParksController < BaseController
    def index
      @car_parks = CarPark.all
    end
  end
end
