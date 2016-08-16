class ShippingMethod < ActiveRecord::Base
  belongs_to :order
end
