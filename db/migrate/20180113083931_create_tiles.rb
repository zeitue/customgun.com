class CreateTiles < ActiveRecord::Migration[5.1]
  def change
    create_table :tiles do |t|
      t.string :title, null: false, default: ""
      t.string :text, null: false, default: ""
      t.string :url, null: false, default: ""
      t.string :group, null: false, default: ""
      t.string :image, null: false, default: ""
      t.boolean :show, null: false, default: true

      t.timestamps
    end
  end
end
