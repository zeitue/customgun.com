class OrdersController < ApplicationController
  layout 'store'
  before_action :set_order, only: [:edit, :update, :invoice, :print]
  before_action :authenticate_admin!, only: [:new, :edit, :create, :destroy, :carts]

  def index
    if current_user.admin
      @orders = Kaminari.paginate_array(Order.where(phase: 6).order('ordered_on DESC')).page(params[:page]).per(8)
    # (User.all.map {|user| user.orders.map {|order| order unless order.items.count == 0 || order.shipping_methods.count == 0 || user.orders.last == order }.compact }).compact.reject(&:empty?).flatten.sort_by(&:ordered_on).reverse
    # For update
    # (User.all.map {|user| user.orders.map {|order| order unless order.items.count == 0 || order.shipping_methods.count == 0 || user.orders.last == order }.compact }).compact.reject(&:empty?).flatten.sort_by(&:ordered_on).reverse.each {|e| e.update_attributes(phase: 6) }
    else
      @orders =  Kaminari.paginate_array(current_user.orders.where('ordered_on IS NOT NULL and phase = 6').sort_by(&:ordered_on).reverse).page(params[:page]).per(8)
    end
  end

  def show
    check_ownership(@order)
  end

  def carts
    #@orders = Kaminari.paginate_array((User.all.map {|user| user.orders.last unless user.orders.last.items.count == 0}).compact.flatten.sort_by(&:updated_at).reverse).page(params[:page]).per(8)
    @orders = Kaminari.paginate_array(Order.carts).page(params[:page]).per(8)
  end

  def invoice
    check_ownership(@order)
  end

  def print
    render :layout => false
    check_ownership(@order)
  end

  def details
    @order = set_order
    check_ownership(@order)
  end

  def update
    check_ownership(@order)
    if @order.update(order_params)
      update_attachments if params[:order][:shipping_methods_attributes]
      if params[:process_order]
        redirect_to process_order_path
      elsif params[:packaging]
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
    params.require(:order).permit(:user_id, :subtotal, :total, :tax, :address_id, :comment, :ordered_on, :phase, shipping_methods_attributes: [:id, :service_name, :price])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def update_attachments
    Order.find(params[:id]).shipping_methods.each(&:destroy) if Order.find(params[:id]).shipping_methods.present?
    params[:order][:shipping_methods_attributes].each do |_a, b, _c|
      price = b[:price].partition(' ')[0]
      service_name = eval(b[:price].partition(' ')[2])[:service_name]
      Order.find(params[:id]).shipping_methods.create(service_name: service_name, price: price, id: b[:id])
    end
  end
end
