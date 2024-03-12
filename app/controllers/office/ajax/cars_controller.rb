# frozen_string_literal: true

module Office
  module AJAX
    class CarsController < BaseController
      def inspect
        operation = Operations::Office::Cars::Inspect.new
        result = operation.call(params[:id], car_params.to_h, responsible_params.to_h)

        case result
        in Success[car]
          render "office/ajax/success"
        in Failure[error_code, errors]
          render "office/ajax/errors", locals: {error_code: error_code, errors: errors}
        end
      end

      private

      def car_params
        params.require(:car).permit(:technical_condition, :appearance)
      end

      def responsible_params
        params.require(:responsible).permit(:id, :type)
      end
    end
  end
end
