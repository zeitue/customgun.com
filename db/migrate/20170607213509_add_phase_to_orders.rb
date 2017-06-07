class AddPhaseToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :phase, :integer, default: 0
  end
end
