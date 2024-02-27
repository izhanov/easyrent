# frozen_string_literal: true

module Office
  module AJAX
    class OffersController < BaseController
      def show
        @offer = Offer.find(params[:id])
      end
    end
  end
end
