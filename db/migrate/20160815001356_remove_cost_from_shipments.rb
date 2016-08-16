class RemoveCostFromShipments < ActiveRecord::Migration
  def change
    remove_column :shipments, :cost, :float
  end
end
