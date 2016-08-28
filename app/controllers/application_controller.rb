class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  after_filter :store_location
  helper_method :current_user
  helper_method :current_order
  layout :layout_by_resource
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :current_user


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

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      redirect_to products_path, alert: "Operation failed: Permission denied"
    end
  end


  def check_ownership(object)
    unless (current_user.id == object.user.id || current_user.admin?)
      redirect_to products_path, alert: "Operation failed: Permission denied"
    end
  end

  def get_operating_system
    user_agent = request.env['HTTP_USER_AGENT'].downcase;
    if user_agent.match(/mac/i)
      "Mac"
    elsif user_agent.match(/ios|iphone|ipad|ipod/i)
      "iOS"
    elsif user_agent.match(/linux/i)
      "Linux"
    elsif user_agent.match(/android/i)
      "Android"
    elsif user_agent.match(/freebsd/i)
      "FreeBSD"
    elsif user_agent.match(/openbsd/i)
      "OpenBSD"
    elsif user_agent.match(/netbsd/i)
      "NetBSD"
    elsif user_agent.match(/dragonfly/i)
      "DragonFlyBSD"
    elsif user_agent.match(/bsd/i)
      "BSD"
    elsif user_agent.match(/solaris/i)
      "Solaris"
    elsif user_agent.match(/sunos/i)
      "SunOS"
    elsif user_agent.match(/unix/i)
      "Unix"
    elsif user_agent.match(/amigaos/i)
      "AmigaOS"
    elsif user_agent.match(/beos/i)
      "BeOS"
    elsif user_agent.match(/aros/i)
      "AROS"
    elsif user_agent.match(/haiku/i)
      "Haiku"
    elsif user_agent.match(/dos/i)
      "DOS"
    elsif user_agent.match(/windows/i)
      "Windows"
    elsif user_agent.match(/java/i)
      "Java"
    elsif user_agent.match(/googlebot/i)
      "GoogleBot"
    elsif user_agent.match(/baiduspider/i)
      "BaiduSpider"
    elsif user_agent.match(/bingbot/i)
      "BingBot"
    elsif user_agent.match(/facebook/i)
      "Facebook"
    elsif user_agent.match(/domainappender/i)
      "DomainAppender"
    else
      user_agent
    end
  end




  def current_order
    current_user.orders.last
  end


  def current_user
    super || guest_user
  end

  def guest_user?
    guest_user
  end

  private

  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    user = User.new { |user| user.guest = true }
    user.email = "guest#{Time.now.to_i.to_s(16)}#{rand(99).to_s(16)}_#{get_operating_system.downcase}@customgun.com"
    user.save(:validate => false)
    user
  end


  protected

  def layout_by_resource
    if devise_controller?
      "store"
    else
      "application"
    end
  end


  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end
