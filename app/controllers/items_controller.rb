class ItemsController < ApplicationController
  layout 'store'
  respond_to :html, :js

  def create
    @order = current_order

    if @order.items.where(product_id: item_params[:product_id]).empty?
      @item = @order.items.new(item_params)
      @order.save
    else
      @item = @order.items.where(product_id: item_params[:product_id]).first
      if (item_params[:quantity].to_i + @item.quantity.to_i) <= Product.where(id: @item.product_id).first.quantity
        @item.update_attributes(quantity: (item_params[:quantity].to_i + @item.quantity.to_i))
      else
        @item.update_attributes(quantity: Product.where(id: @item.product_id).first.quantity)
      end
      @order.save
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    flash[:notice] = "Item was added to your shopping cart."
  end

  def update

    @order = current_order
    @item = @order.items.find(params[:id])
    @item.update_attributes(item_params)
    @items = @order.items
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    flash[:notice] = "Item quantity was updated in your shopping cart."
  end

  def destroy
    @order = current_order
    @item = @order.items.find(params[:id])
    @item.destroy
    @items = @order.items
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
    flash[:notice] = "Item was removed from your shopping cart."
  end

private
  def item_params
    params.require(:item).permit(:quantity, :product_id)
  end
end
