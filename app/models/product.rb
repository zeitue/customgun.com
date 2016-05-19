class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :title
  has_many :photos
  accepts_nested_attributes_for :photos
end
