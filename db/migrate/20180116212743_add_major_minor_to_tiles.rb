class AddMajorMinorToTiles < ActiveRecord::Migration[5.1]
  def change
    add_column :tiles, :major, :integer
    add_column :tiles, :minor, :integer
  end
end
