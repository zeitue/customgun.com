class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.references :order, index: true, foreign_key: true
      t.float :cost
      t.string :tracking

      t.timestamps null: false
    end
  end
end
