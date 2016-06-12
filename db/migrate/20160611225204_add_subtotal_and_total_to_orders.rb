class AddSubtotalAndTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal, :float
    add_column :orders, :total, :float
  end
end
