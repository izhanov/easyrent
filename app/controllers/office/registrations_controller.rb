# frozen_string_literal: true

class Office::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  layout "office"
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    validation = Validations::Office::Users::Create.new.call(sign_up_params.to_h)

    if validation.success?
      resource_params[:phone] = sanitize_phone_number(sign_up_params[:phone])
      super
    else
      flash[:alert] = "fuck you"
      @resource = build_resource(sign_up_params)

      validation.errors.to_h.each do |error_key, error_message|
        @resource.errors.add(error_key.to_sym, error_message.join)
      end

      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :email,
        :password,
        :password_confirmation,
        :phone,
        :kind,
        :first_name,
        :last_name
      )
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    office_root_path
  end

  def sanitize_phone_number(phone_number)
    phone_number.gsub(/[^0-9\+]/, "")
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
