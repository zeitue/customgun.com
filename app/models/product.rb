class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  has_many :photos
  accepts_nested_attributes_for :photos
  before_validation :default_values

  def default_values
    self.title = self.title.strip.downcase
    self.manufacturer = self.manufacturer.strip.downcase
    self.model = self.model.strip.downcase
    self.type_field = self.type_field.strip.downcase
    self.style_field = self.style_field.strip.downcase
    self.material = self.material.strip.downcase
    self.caliber = self.caliber.strip.downcase
    self.part_number = self.part_number.strip.downcase
    self.url = self.title.strip.parameterize
    self.tags = self.tags.strip.downcase
  end

end
