class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :shipment, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity
      t.float :price

      t.timestamps null: false
    end
  end
end
