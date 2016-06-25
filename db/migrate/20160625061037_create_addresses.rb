class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :country
      t.string :state
      t.string :city
      t.string :zip
      t.string :phone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
