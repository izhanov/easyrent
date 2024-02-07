# frozen_string_literal: true

module Office
  class PriceRangeCellsController < BaseController
    before_action :find_car_park, :find_price_range
    before_action :find_price_range_cell, only: %i[edit update destroy]

    def index
    end

    def new
      @price_range_cell = PriceRangeCell.new
    end

    def create
      operation = Operations::Office::PriceRangeCells::Create.new
      result = operation.call(price_range_cell_params.to_h)
      case result
      in Success[price_range_cell]
        @price_range_cell = price_range_cell
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure
        @price_range_cell = PriceRangeCell.new(price_range_cell_params)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      operation = Operations::Office::PriceRangeCells::Update.new
      result = operation.call(@price_range_cell, price_range_cell_params.to_h)

      case result
      in Success[price_range_cell]
        @price_range_cell = price_range_cell
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[error_code, errors]
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @price_range_cell.destroy

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    private

    def price_range_cell_params
      params.require(:price_range_cell).permit(:from, :to, :price_range_id)
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def find_price_range
      @price_range = @car_park.price_range
    end

    def find_price_range_cell
      @price_range_cell ||= PriceRangeCell.find(params[:id])
    end
  end
end
