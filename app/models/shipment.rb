class Shipment < ActiveRecord::Base
  belongs_to :order
  has_many :items
  before_destroy :destroy_associated
  
  def destroy_associated
    self.items.destroy_all
  end
end
