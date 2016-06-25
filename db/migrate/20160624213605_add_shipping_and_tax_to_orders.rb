class AddShippingAndTaxToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax, :float
    add_column :orders, :shipping, :float
  end
end
