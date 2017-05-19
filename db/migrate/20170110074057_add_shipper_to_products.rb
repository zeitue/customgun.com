class AddShipperToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :shipper, index: true, foreign_key: true
  end
end
