class Product < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  include FriendlyId
  friendly_id :url
  has_many :photos
  accepts_nested_attributes_for :photos
before_save :default_values
  def default_values
    self.url = self.title.parameterize
  end

end
