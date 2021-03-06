class ApplicationController < ActionController::Base
  # Joe and Tim added code for Devise functionality
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_login!

  #Redirection to make sure unauthorized don't have access to pages besides log in
  def unauthorized
    flash[:alert] = "You are not authorized to view that page."
    redirect_to '/'
  end

  protected

  # Allows sign_up to accept more login fields and login to take new username key
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :middle_initial, :last_name, :username, :type, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:logon, :username, :email, :password, :remember_me) }
  end
end
