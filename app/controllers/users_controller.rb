class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :destroy, :index]
  layout "store"
def show
  @user = User.find(params[:id])
end

def index
  @users = User.all
end

 def destroy
    @user = User.find(params[:id])

    if @user.destroy
        redirect_to users_path, notice: "User deleted."
    end
  end
end
