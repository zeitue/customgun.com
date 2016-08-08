class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items
  before_destroy :destroy_items

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

  def update_prices
    self.items.each do |item|
      item.price = Product.find(item.product_id).price
      item.save!
    end
  end


  def update_total
    self.total = self.subtotal.to_f + self.tax.to_f + self.shipping.to_f
    self.save!
  end

   private

   def destroy_items
     self.items.destroy_all   
   end

end
