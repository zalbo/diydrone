
  class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password , :firstname , :lastname , :nickname) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :full_name, :description, :password, :current_password, :password_confirmation, :avatar)}

    end
    protect_from_forgery with: :exception
  end
