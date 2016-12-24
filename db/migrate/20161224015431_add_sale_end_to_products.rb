class AddSaleEndToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale_end, :datetime
  end
end
