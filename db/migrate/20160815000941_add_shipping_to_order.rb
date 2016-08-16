class AddShippingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping, :float
  end
end
