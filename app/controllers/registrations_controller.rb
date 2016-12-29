class RegistrationsController < Devise::RegistrationsController

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end



  protected

  def after_update_path_for(_resource)
    products_path
  end

  def after_sign_up_path_for(_resource)
    products_path
  end

  def after_inactive_sign_up_path_for(_resource)
    products_path
  end


  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end



  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
