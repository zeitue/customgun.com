class AddCompressibleToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :compressible, :boolean, null: false, default: false
  end
end
