class OrdersController < ApplicationController
  layout 'store'
  def index
  @orders = current_user.orders
  end
end
