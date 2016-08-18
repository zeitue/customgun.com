class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  has_many :photos
  accepts_nested_attributes_for :photos
  before_validation :default_values
  before_destroy :destroy_associated
  

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
    self.shipped_by = self.shipped_by.blank? ? nil : self.shipped_by.strip.downcase
  end


  def destroy_associated
    self.photos.destroy_all
  end
end
