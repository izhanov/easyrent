# frozen_string_literal: true

module Office
  class OffersController < BaseController
    before_action :find_offer, only: %i[show edit update destroy]
    before_action :find_car, :find_car_park

    def index
      @offers = @car.offers.order(id: :asc)
    end

    def show
    end

    def new
      @offer = Offer.new
    end

    def edit
    end

    def create
      operation = Operations::Office::Offers::Create.new
      result = operation.call(offer_params.to_h)

      case result
      in Success[offer]
        @offer = offer
        respond_to do |format|
          format.html { redirect_to office_car_park_car_offer_path(@car_park, @car, @offer) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @offer = Offer.new(offer_params)
        @errors = errors
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        render :new, status: :unprocessable_entity
      end
    end

    def update
      operation = Operations::Office::Offers::Update.new
      result = operation.call(@offer, offer_params.to_h)

      case result
      in Success[offer]
        @offer = offer
        respond_to do |format|
          format.html { redirect_to office_car_park_car_offer_path(@car_park, @car, @offer) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @offer.destroy!
      respond_to do |format|
        format.html { redirect_to office_car_park_car_path(@car_park, @car), notice: "Offer was successfully destroyed." }
        format.turbo_stream
      end
    end

    def select
      @offers = @car.offers.order(id: :asc)
      render partial: "office/offers/select", locals: {offers: @offers}
    end

    private

    def find_offer
      @offer = current_office_user.offers.find(params[:id])
    end

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def find_car_park
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
    end

    def offer_params
      params.require(:offer).permit(
        :title,
        :car_id,
        :published,
        :mileage_limit_id,
        :pledge_amount,
        prices: {}
      )
    end
  end
end
