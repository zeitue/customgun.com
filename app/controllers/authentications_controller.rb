class AuthenticationsController < ApplicationController
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]
  layout 'store'

  def handle_unverified_request
    true
  end

  # GET /authentications
  def index
    @authentications = current_user.authentications if current_user
  end

  # GET /authentications/1
  def show
  end

  # GET /authentications/new
  def new
    @authentication = Authentication.new
  end

  # GET /authentications/1/edit
  def edit
  end

  # POST /authentications
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user && !current_user.guest
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  # PATCH/PUT /authentications/1
  def update
    if @authentication.update(authentication_params)
      redirect_to @authentication, notice: 'Authentication was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /authentications/1
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_authentication
    @authentication = Authentication.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def authentication_params
    params.require(:authentication).permit(:user_id, :provider, :uid)
  end
end
