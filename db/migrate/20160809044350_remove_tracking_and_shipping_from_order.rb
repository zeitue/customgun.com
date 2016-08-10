class RemoveTrackingAndShippingFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :tracking, :float
    remove_column :orders, :shipping, :float
  end
end
