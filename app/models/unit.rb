class Unit < ActiveRecord::Base
  belongs_to :shipment
  belongs_to :product
end
