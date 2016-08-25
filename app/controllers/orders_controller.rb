class OrdersController < ApplicationController
  layout 'store'
  before_action :set_order, only: [:edit, :update]
  
  def index
    @orders = current_user.orders.sort_by(&:id).reverse.drop(1)
  end
  
  def show
  end

  def carts
    @orders = User.all.map { |user| user.orders.last unless user.orders.last.items.count == 0}.reverse
  end

  def invoice
    @order = set_order
  end

  def details
    @order = set_order
  end

  def update
    update_attachments if params[:order][:shipping_methods_attributes]
    if @order.update(order_params)
      if params[:packaging]
        redirect_to packaging_path
      else
        redirect_to shipping_select_path
      end
    else
      render :edit
    end
  end

  def edit
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :subtotal, :total, :tax, :address_id, shipping_methods_attributes: [:id, :service_name, :price ])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def update_attachments
    Order.find(params[:id]).shipping_methods.each(&:destroy) if Order.find(params[:id]).shipping_methods.present?
    params[:order][:shipping_methods_attributes].each do |a, b, c|
      price = b[:price].partition(' ')[0]
      service_name = eval(b[:price].partition(' ')[2])[:service_name]
      Order.find(params[:id]).shipping_methods.create!(:service_name => service_name, :price => price, :id => b[:id])
    end
  end
end
