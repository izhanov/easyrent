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
      @user = User.new(user_params)

      if @user.save
        redirect_to admins_user_path(@user), notice: "User was successfully created."
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admins_user_path(@user), notice: "User was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admins_users_path, notice: "User was successfully destroyed."
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
    end
  end
end
