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
    self.title = self.title.to_s.strip.downcase
    self.manufacturer = self.manufacturer.to_s.strip.downcase
    self.model = self.model.to_s.strip.downcase
    self.type_field = self.type_field.to_s.strip.downcase
    self.style_field = self.style_field.to_s.strip.downcase
    self.material = self.material.to_s.strip.downcase
    self.caliber = self.caliber.to_s.strip.downcase
    self.part_number = self.part_number.to_s.strip.downcase
    self.url = self.title.strip.parameterize
    self.tags = self.tags.to_s.strip.downcase
    self.shipped_by = self.shipped_by.blank? ? nil : self.shipped_by.to_s.strip.downcase
    self.diopter_adjustment = self.diopter_adjustment.to_s.strip.downcase
    self.elevation_travel = self.elevation_travel.to_s.strip.downcase
    self.windage_travel = self.windage_travel.to_s.strip.downcase
    self.total_travel = self.total_travel.to_s.strip.downcase
    self.position_of_reticle = self.position_of_reticle.to_s.strip.downcase
    self.available_reticles = self.available_reticles.to_s.strip.downcase
  end


  def destroy_associated
    self.photos.destroy_all
  end

  def get_price
    if sale
      sale_price
    else
      price
    end
  end
end
