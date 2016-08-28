class OrdersController < ApplicationController
  layout 'store'
  before_action :set_order, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:new, :edit, :create, :destroy, :carts]
  
  def index
    if current_user.admin
      @orders = (User.all.map do |user| user.orders.map  do |order| order unless (order.items.count == 0 || order.shipping_methods.count == 0 || user.orders.last == order) end.compact end).compact.reject(&:empty?).flatten.reverse

    else
      @orders = current_user.orders.sort_by(&:id).reverse.drop(1)
    end
  end
  
  def show
    check_ownership(@order)
  end

  def carts
    @orders = User.all.map { |user| user.orders.last unless user.orders.last.items.count == 0}.reverse
  end

  def invoice
    @order = set_order
    check_ownership(@order)
  end

  def details
    @order = set_order
    check_ownership(@order)
  end

  def update
    check_ownership(@order)
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
    check_ownership(@order)
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
