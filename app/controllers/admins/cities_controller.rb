# frozen_string_literal: true

module Admins
  class CitiesController < BaseController
    def index
      @cities = City.all
    end
  end
end
