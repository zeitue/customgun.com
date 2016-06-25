class RemoveAddressCountryStateCityZipCodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address
    remove_column :users, :country
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :zip_code
    remove_column :users, :phone
  end
end
