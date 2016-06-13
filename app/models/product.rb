class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  has_many :photos
  accepts_nested_attributes_for :photos
  before_save :default_values

  def default_values
    self.url = self.title.parameterize
  end

end
