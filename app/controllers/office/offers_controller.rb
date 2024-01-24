# frozen_string_literal: true

module Office
  class OffersController < BaseController
    before_action :find_offer, only: %i[show edit update destroy]
    before_action :find_car

    def index
      @offers = Offer.all
    end

    def show; end

    def new
      @offer = Offer.new
    end

    def edit; end

    def create
      operation = Operations::Office::Offers::Create.new
      result = operation.call(offer_params.to_h)

      case result
      in Success[offer]
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @offer = Offer.new(offer_params)
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @offer.update(offer_params)
        redirect_to office_offer_path(@offer), notice: 'Offer was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @offer.destroy
      redirect_to office_offers_url, notice: 'Offer was successfully destroyed.'
    end

    private

    def find_offer
      @offer = current_office_user.offers.find(params[:id])
    end

    def find_car
      @car = current_office_user.cars.find(params[:car_id])
    end

    def offer_params
      params.require(:offer).permit(:title, :car_id, prices: {}, services: {}, rules: {})
    end
  end
end
