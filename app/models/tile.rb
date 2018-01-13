class Tile < ApplicationRecord
  mount_uploader :image, TileUploader
end
