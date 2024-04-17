# frozen_string_literal: true

module Office
  class CarParksCarsController < BaseController
    helper CarsHelper

    def index
      query = Utils::Typesense::Cars::QueryBuilder.new(**query_params).call

      @q = Car.typesense(query)
      relation = current_office_user.cars.where(id: @q.pluck(:id)).order(:id)
      @pagy, @cars = pagy(relation, items: 10)
    end

    private

    def query_params
      return params.require(:q).permit(:query, :car_park_id, :status).to_h.deep_symbolize_keys if params[:q]

      {}
    end
  end
end
