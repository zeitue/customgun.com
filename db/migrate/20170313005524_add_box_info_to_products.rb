class AddBoxInfoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :has_box, :boolean, :default => false
    add_column :products, :shipping_height, :float, :default => 0
    add_column :products, :shipping_width, :float, :default => 0
    add_column :products, :shipping_length, :float, :default => 0
    add_column :products, :shipping_weight, :float, :default => 0
  end
end
