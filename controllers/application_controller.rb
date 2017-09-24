class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?

after_filter :store_location
before_action :stop_banned_user

def store_location
  return unless request.get? 
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      request.path != "/admins/sign_in" &&
      request.path != "/admins/sign_up" &&
      request.path != "/admins/password/new" &&
      request.path != "/admins/password/edit" &&
      request.path != "/admins/confirmation" &&
      request.path != "/admin/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

def after_sign_out_path_for(resource)
  request.referrer
end

def stop_banned_user
  unless current_user.nil?
    if current_user.banned?
    sign_out current_user
    redirect_to welcome_banned_path
    end
  end
end

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_in)        << :username
  devise_parameter_sanitizer.for(:sign_up)        << :username
  devise_parameter_sanitizer.for(:account_update) << :username
  end
end
