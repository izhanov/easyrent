# frozen_string_literal: true

module Office
  class TempPasswordsController < BaseController
    skip_before_action :authenticate_office_user!, only: %i[edit update]
    skip_before_action :reset_temp_password?, only: %i[edit update]
    include Devise::Controllers::SignInOut

    def edit
    end

    def update
      operation = Operations::Office::Users::ChangePassword.new
      result = operation.call(params[:user_id], params[:password], params[:password_confirmation])

      case result
      in Success
        sign_in(:office_user, result.value!)
        redirect_to office_root_path, flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = error_resolver(operation, error_code, errors)
        render :edit
      end
    end
  end
end
