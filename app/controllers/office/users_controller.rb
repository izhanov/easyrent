# frozen_string_literal: true

module Office
  class UsersController < BaseController
    def edit
    end

    def update
      operation = Operations::Office::Users::Update.new
      result = operation.call(current_office_user, user_params.to_h)

      case result
      in Success[office_user]
        success_message = {success: success_resolver(operation)}
        redirect_to edit_office_user_path, flash: success_message
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone)
    end
  end
end
