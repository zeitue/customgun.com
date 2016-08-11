class OrdersController < ApplicationController
  layout 'store'
  before_action :set_order, only: [:edit, :update]
  
  def index
  @orders = current_user.orders
  end

  def update
    if @order.update(order_params)
      redirect_to shipping_select_path
    else
      render :edit
    end
  end

  def edit
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :subtotal, :total, :tax, :address_id)
  end

      # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end
