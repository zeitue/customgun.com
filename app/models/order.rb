class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items
  def quantity
    self.items.collect { |oi| oi.valid? ? oi.quantity.to_i : 0 }.sum
  end

  def subtotal
    value = 0.0
    self.items.each do |item|
      value += item.price.to_f * item.quantity.to_i
    end
    value
  end

  def update_prices
    self.items.each do |item|
      item.price = Product.find(item.product_id).price
    end
  end



end
