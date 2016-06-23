class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  has_many :photos
  accepts_nested_attributes_for :photos
  before_save :default_values

  def default_values
    self.title.downcase!
    self.manufacturer.downcase!
    self.model.downcase!
    self.type_field.downcase!
    self.style_field.downcase!
    self.material.downcase!
    self.caliber.downcase!
    self.part_number.downcase!
    self.url = self.title.parameterize
    self.tags.downcase!
  end

end
