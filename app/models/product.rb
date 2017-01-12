class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  has_many :photos
  accepts_nested_attributes_for :photos
  before_validation :default_values
  before_destroy :destroy_associated
  belongs_to :shipper
  validates_presence_of :shipper

  def default_values
    self.title = title.to_s.strip.downcase
    self.manufacturer = manufacturer.to_s.strip.downcase
    self.model = model.to_s.strip.downcase
    self.type_field = type_field.to_s.strip.downcase
    self.style_field = style_field.to_s.strip.downcase
    self.material = material.to_s.strip.downcase
    self.caliber = caliber.to_s.strip.downcase
    self.part_number = part_number.to_s.strip.downcase
    self.url = title.strip.parameterize
    self.tags = tags.to_s.strip.downcase
    self.shipped_by = shipped_by.blank? ? nil : shipped_by.to_s.strip.downcase
    self.diopter_adjustment = diopter_adjustment.to_s.strip.downcase
    self.elevation_travel = elevation_travel.to_s.strip.downcase
    self.windage_travel = windage_travel.to_s.strip.downcase
    self.total_travel = total_travel.to_s.strip.downcase
    self.position_of_reticle = position_of_reticle.to_s.strip.downcase
    self.available_reticles = available_reticles.to_s.strip.downcase
  end

  def destroy_associated
    photos.destroy_all
  end

  def get_price
    if sale
      sale_price
    else
      price
    end
  end

  def get_savings
    price - sale_price
  end

  def get_percent_saved
    ((price - sale_price) / price * 100).round(2)
  end

  def update_on_sale
    if self.sale_end && Time.now > self.sale_end
      self.sale = false;
      self.save!
    end
  end
end
