# frozen_string_literal: true

module Admins
  class UsersController < Admins::BaseController
    before_action :find_user, only: %i[show edit update destroy]

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      operation = Operations::Admins::Users::Create.new
      result = operation.call(user_params.to_h)

      case result
      in Success[user]
        redirect_to admins_user_path(User.last), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @user = User.new(user_params)
        @errors = errors
        render :new, status: :unprocessable_entity
      end
    end

    def update
      operation = Operations::Admins::Users::Update.new
      result = operation.call(@user, user_params.to_h)

      case result
      in Success[user]
        redirect_to admins_user_path(@user), flash: {success: success_resolver(operation)}
      in Failure[error_code, errors]
        flash.now[:error] = failure_resolver(operation, error_code: error_code)
        @errors = errors
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy!
      redirect_to admins_users_path, flash: {success: success_resolver(path: "users.destroy")}
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :kind
      )
    end
  end
end
