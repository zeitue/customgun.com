class RemoveNameFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :name, :string
  end
end
