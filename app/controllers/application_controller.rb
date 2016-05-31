class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_filter :store_location

def store_location

  return unless request.get? 
  if (request.path != "/" &&
      request.path != "/store/users/sign_in" &&
      request.path != "/store/users/sign_up" &&
      request.path != "/store/users/password/new" &&
      request.path != "/store/users/password/edit" &&
      request.path != "/store/users/confirmation" &&
      request.path != "/store/users/sign_out" &&
      !request.xhr?)
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || products_path
end

def after_sign_out_path_for(resource_or_scope)
  request.referrer
end

  layout :layout_by_resource
  protected

  def layout_by_resource
    if devise_controller?
      "store"
    else
      "application"
    end
  end
  protect_from_forgery
end
