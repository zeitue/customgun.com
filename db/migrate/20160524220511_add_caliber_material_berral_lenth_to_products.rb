class AddCaliberMaterialBerralLenthToProducts < ActiveRecord::Migration
  def change
    add_column :products, :caliber, :string
    add_column :products, :material, :string
    add_column :products, :barrel_length, :string
  end
end
