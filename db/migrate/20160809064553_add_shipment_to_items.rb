class AddShipmentToItems < ActiveRecord::Migration
  def change
    add_reference :items, :shipment, index: true, foreign_key: true
  end
end
