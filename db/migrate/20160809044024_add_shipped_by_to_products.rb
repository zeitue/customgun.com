class AddShippedByToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipped_by, :string
  end
end
