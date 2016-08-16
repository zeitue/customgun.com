class Shipment < ActiveRecord::Base
  belongs_to :order
  has_many :units
  before_destroy :destroy_associated
  
  def destroy_associated
    self.units.destroy_all
  end
end
