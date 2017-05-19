class AddOrderedOnToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ordered_on, :datetime
    change_column_default :orders, :comment, nil
  end
end
