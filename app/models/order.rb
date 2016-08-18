class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :shipments
  has_many :shipping_methods
  has_one :address
  before_destroy :destroy_items
  accepts_nested_attributes_for :shipping_methods

  def get_address
    address = Address.where(id: self.address_id).first
    if address != nil
      address
    else
      nil
    end
  end
  
  def quantity
    self.items.collect { |oi| oi.valid? ? oi.quantity.to_i : 0 }.sum
  end


  def update_order
    update_prices
    update_subtotal
    update_total
  end

  def update_subtotal
    self.subtotal = 0.0
    self.items.each do |item|
      self.subtotal += item.price.to_f * item.quantity.to_i
    end
    self.save!
  end

  def total_before_tax
    self.subtotal.to_f + self.shipping.to_f + 3
  end
  
  def update_prices
    self.items.each do |item|
      item.price = Product.find(item.product_id).price
      item.save!
    end
  end


  def update_total
    self.total = '%.2f' % (self.subtotal.to_f + self.tax.to_f + self.shipping.to_f + 3)
    self.save!
  end

  def update_items
    self.items.each do |item|
      if item.product.quantity == 0
        item.destroy
      elsif item.product.quantity < item.quantity
        item.quantity = item.product.quantity
        item.save!
      end
    end
  end

   private

   def destroy_items
     self.items.destroy_all
     self.shipping_methods.destroy_all
     self.shipments.destroy_all
   end

end
