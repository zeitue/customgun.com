class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :shipments
  has_many :shipping_methods
  has_one :address
  before_destroy :destroy_items
  accepts_nested_attributes_for :shipping_methods

  def get_address
    address = Address.where(id: address_id).first
    address unless address.nil?
  end

  def quantity
    items.collect { |oi| oi.valid? ? oi.quantity.to_i : 0 }.sum
  end

  def cost
    items.collect { |oi| oi.valid? ? oi.price.to_i : 0 }.sum
  end

  def shipping_and_handling
    shipping.to_f + (0.20 * shipping.to_f)
  end

  def update_order
    update_prices
    update_subtotal
    update_total
  end

  def update_subtotal
    self.subtotal = 0.0
    items.each do |item|
      self.subtotal += item.price.to_f * item.quantity.to_i
    end
    save!
  end

  def total_before_tax
    self.subtotal.to_f + shipping.to_f + (0.20 * shipping.to_f)
  end

  def update_prices
    items.each do |item|
      item.price = Product.find(item.product_id).get_price
      item.save!
    end
  end

  def update_total
    self.total = '%.2f' % (self.subtotal.to_f + tax.to_f + shipping.to_f + (0.20 * shipping.to_f))
    save!
  end

  def update_items
    items.each do |item|
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
    items.destroy_all
    shipping_methods.destroy_all
    shipments.destroy_all
  end
end
