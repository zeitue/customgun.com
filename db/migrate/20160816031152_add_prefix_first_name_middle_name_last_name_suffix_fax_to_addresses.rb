class AddPrefixFirstNameMiddleNameLastNameSuffixFaxToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :prefix, :string
    add_column :addresses, :first_name, :string
    add_column :addresses, :middle_name, :string
    add_column :addresses, :last_name, :string
    add_column :addresses, :suffix, :string
    add_column :addresses, :fax, :string
  end
end
