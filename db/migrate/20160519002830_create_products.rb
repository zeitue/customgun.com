class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :manufacturer
      t.string :model
      t.string :part_number
      t.float :price
      t.integer :quantity
      t.text :description
      t.string :images
      t.string :schematic
      t.float :weight
      t.float :height
      t.float :width
      t.float :length
      t.string :tags
      t.string :categories
      t.boolean :exclusive

      t.timestamps null: false
    end
  end
end
