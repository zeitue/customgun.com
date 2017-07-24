class AddVoidedItmsCountToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :voided, :boolean, null: false, default: false
    add_column :orders, :items_count, :integer, null: false, default: 0
  end
end
