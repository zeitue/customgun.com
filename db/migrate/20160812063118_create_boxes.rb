class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :provider
      t.float :length
      t.float :height
      t.float :width
      t.float :weight

      t.timestamps null: false
    end
  end
end
