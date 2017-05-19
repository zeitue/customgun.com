class CreateShippers < ActiveRecord::Migration[5.0]
  def change
    create_table :shippers do |t|
      t.string :name, :default => '' 
      t.string :company_name, :default => ''
      t.integer :scheme, :default => 0
      t.float :price, :default => 0.00
      t.float :handling_fee, :default => 0.00
      t.float :up_charge_rate, :default => 0.00
      t.references :address, index: true, foreign_key: true
      t.boolean :usps, :default => false
      t.boolean :fedex, :default => false
      t.boolean :ups, :default => false
      t.timestamps null: false
    end
  end
end
