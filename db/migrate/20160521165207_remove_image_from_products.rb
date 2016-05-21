class RemoveImageFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :images
  end
end
