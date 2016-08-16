class RemoveShipmentFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :shipment, :reference
  end
end
