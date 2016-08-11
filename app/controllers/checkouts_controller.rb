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
  end

  
end
