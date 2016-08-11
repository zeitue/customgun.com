class CheckoutsController < ApplicationController

  layout 'store'

  def show
  end

  def address_select
    @addresses = Address.where(user_id: current_user.id)
    @address = Address.new
    @order = current_order
  end

  def shipping_select
    @order = current_order
    product_ids = @order.items.map{|h| h.product_id}
    shippers = Product.where(id: product_ids).uniq.pluck(:shipped_by)
    shippers.each do |name|
      if (Shipment.where(order_id: @order.id, shipped_by: name).count == 0)
        Shipment.create(order_id: @order.id, shipped_by: name)
      end
    end

    @order.shipments.where.not(shipped_by: shippers).destroy_all
    
    @order.items.each do |item|
      item.shipment_id = @order.shipments.where(shipped_by: Product.where(id: item.product_id).first.shipped_by).first.id
      item.save
    end
  end
  
end
