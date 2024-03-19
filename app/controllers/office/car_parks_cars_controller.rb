# frozen_string_literal: true

module Office
  class CarParksCarsController < BaseController
    def index
      @cars = current_office_user.cars
    end
  end
end
