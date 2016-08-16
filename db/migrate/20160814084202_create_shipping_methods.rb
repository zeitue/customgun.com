class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods do |t|
      t.references :order, index: true, foreign_key: true
      t.float :price
      t.string :service_name

      t.timestamps null: false
    end
  end
end
