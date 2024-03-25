# frozen_string_literal: true

module Office
  class CarParksCarsController < BaseController
    def index
      @q = Car.typesense(
        q: query_builder(query_params),
        query_by: "plate_number, owner.id, mark.title, status",
        infix: "always, always, always, always",
      )

      ids = @q.pluck(:id)
      relation = current_office_user.cars.where(id: ids).order(:id)
      @pagy, @cars = pagy(relation, items: 10)
    end

    private

    def query_builder(q)
      "#{q[:query]} #{q[:car_park_id]} #{q[:status]}"
    end

    def query_params
      return  params.require(:q).permit(:query, :car_park_id, :status) if params[:q]

      {}
    end
  end
end
