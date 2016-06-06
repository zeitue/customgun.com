class CartsController < ApplicationController
  layout 'store'
  def show
    @order = current_order
    @order_items = current_order.items
  end
end
