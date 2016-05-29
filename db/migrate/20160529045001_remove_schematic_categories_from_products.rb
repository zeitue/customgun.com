class RemoveSchematicCategoriesFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :schematic, :string
    remove_column :products, :categories, :string
  end
end
