class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :create, :destroy, :index, :show]
  layout 'store'
  def show
    @user = User.find(params[:id])
    @orders = @user.orders.where('ordered_on IS NOT NULL and phase = 6').sort_by(&:ordered_on).reverse
  end

  def index
    @users = User.order(:id).page(params[:page]).per(8)
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to users_path, notice: 'User deleted.' if @user.destroy
   end
end
