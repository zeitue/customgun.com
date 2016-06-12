class RegistrationsController < Devise::RegistrationsController



  protected

  def after_update_path_for(resource)
    products_path
  end
end
