class AddStyleFieldTypeFieldToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type_field, :string
    add_column :products, :style_field, :string
  end
end
