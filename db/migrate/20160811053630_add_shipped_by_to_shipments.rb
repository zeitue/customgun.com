class AddShippedByToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :shipped_by, :string
  end
end
