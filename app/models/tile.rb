class Tile < ApplicationRecord
  mount_uploader :image, TileUploader
  before_save :clean_up

  def clean_up
    self.title = self.title.to_s.strip
    self.text = self.text.to_s.strip
    self.group = self.group.downcase.to_s.strip
  end

end
