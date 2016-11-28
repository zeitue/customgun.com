class CheckoutsController < ApplicationController

  layout 'store'

  def address_select
    @addresses = Address.where(user_id: current_user.id)
    @address = Address.new
    @order = current_order
  end

  def shipping_select
    current_order.update_items
    @order = current_order
    @shipping_methods = @order.shipping_methods
    product_ids = @order.items.map{|h| h.product_id}
    @shippers = Product.where(id: product_ids).uniq.pluck(:shipped_by).sort_by { |i| [i ? 1 : 0, i] }
    @shippers.count.times { @order.shipping_methods.build }
    Rails.cache.delete(:fedex_packed)
    Rails.cache.delete(:usps_packed)

    @items = @order.items.joins(:product).where(products: {shipped_by: nil})
    if @items.count > 0
      @fedex_packed = make_packages("fedex",@items)
      @usps_packed = make_packages("usps",@items)
      @usps_packages = make_active_packages(@usps_packed)
      @fedex_packages = make_active_packages(@fedex_packed)
      Rails.cache.write(:fedex_packed, @fedex_packed)
      Rails.cache.write(:usps_packed, @usps_packed)
      @destination = make_active_location(@order.get_address)
      @usps = usps_rates(origin, @destination, @usps_packages)
      @fedex = fedex_rates(origin, @destination, @fedex_packages)
    end
  end


  def packaging
    @order = current_order
    @shipping_methods = @order.shipping_methods
    if @shipping_methods.count > 0
      @order.shipments.destroy_all
      @order.shipments = []
      if !@shipping_methods.where("service_name like ?", "%fedex%").first.nil?
        packed = Rails.cache.read(:fedex_packed)
        make_shipments(@order, packed).each {|shipment| @order.shipments.push(shipment)}
      elsif !@shipping_methods.where("service_name like ?", "%usps%").first.nil?
        packed = Rails.cache.read(:usps_packed)
        make_shipments(@order, packed).each {|shipment| @order.shipments.push(shipment)}
      end

      if !@shipping_methods.where("service_name like ?", "%drop shipped%").first.nil?
        @order.shipments.push(make_drop_shipment(@order, "hawkins precision, llc"))
      end
      @order.shipping = @order.shipping_methods.sum(:price)
      st=@order.get_address.state.to_s.downcase
      if  st == "texas" || st == "tx" || st == "lone star state" || st == "beef state" || st == "jumbo state" || st == "super-american state" || st == "banner state" || st == "blizzard state"
        @order.tax = ('%.2f' % ((@order.subtotal + @order.shipping).to_f * 0.0675))
      else
        @order.tax = 0.0
      end
      @order.save
      @order.update_order
    end
  end


  def approved
    @order = current_order
    if @order.items.count > 0
      @order.items.each do |item|
        item.product.quantity -= item.quantity
        item.product.save
      end
      current_user.create_cart
    end
  end

  def disapproved
  end

  private


  def make_drop_shipment(order, shipper)
    shipment = Shipment.new(order_id: order.id, shipped_by: shipper)
    items = order.items.joins(:product).where(products: {shipped_by: shipper})
    items.each do |item|
      shipment.units.new(product_id: item.product.id,
                         quantity: item.quantity,
                         price: item.product.get_price)
    end
    shipment
  end

  def make_shipments(order, packed)
    shipments = []
    packed.each do |entry|
      shipments.push(make_shipment(@order, entry))
    end
    shipments
  end


  def make_shipment(order, packed)
    shipment = Shipment.new(order_id: order.id)
    counts = Hash.new(0)
    packed.packings.first.each {|entry| counts[entry.label]+=1 }
    counts.each do |entry|
      product = Product.where(url: entry.first).first
      shipment.units.new(product_id: product.id,
                         quantity: entry.last,
                         price: product.get_price)
    end
    shipment
  end

  def make_active_packages(packed)
    packages = []
    packed.each do |pack|
      packages.push(make_active_package(pack))
    end
    packages
  end

  def make_active_package(pack) # 1.15 is to give a 15% buffer weight
    ActiveShipping::Package.new((pack.weight_limit-pack.packings.first.remaining_weight)*1.15, [pack.dimensions.x,pack.dimensions.y,pack.dimensions.z])
  end
  
  def make_active_location(address)
    ActiveShipping::Location.new(name: address.prefix.to_s + " " + address.first_name.to_s + " " +  address.middle_name.to_s + address.last_name.to_s + " " + address.suffix.to_s,
                                 address1: address.address_line1,
                                 address2: address.address_line2,
                                 phone: address.phone,
                                 country: address.country,
                                 state: address.state,
                                 city: address.city,
                                 zip: address.zip)
  end

  def make_packages(provider, items)
    individual = items.joins(:product).where(products: {exclusive: true})
    grouped = items.joins(:product).where(products: {exclusive: false})
    packages = []
    individual.each do |item|
      packages.push(best_fit(provider, [item]))
    end

    while grouped.count > 0
      entry = best_fit(provider, grouped)
      packages.push(entry)
      grouped = remove_from(entry, grouped)
    end
    packages
  end

  def remove_from(entry, items)
    items_list = items.dup
    entry.packings.first.each do |package|
      if items_list.each do |item|
           if item.product.url == package.label
             item.quantity-=1
           end
         end
      end
    end
    items_list.reject {|x| x.quantity == 0}
  end
  
  def best_fit(provider, items)
    entries = []
    Box.where(provider: provider).each do |box|
      entries.push(packup(box, items))
    end
    entries.delete_if { |x| x.packings.count  == 0 }
    entries = entries.sort_by {|obj| [obj.packings.count, obj.packings.first.remaining_volume]}
    if entries.first.packings.count > 1
      entries.first.packings.pop(entries.first.packings.count-1)
    end
    entries.first
  end

  def packup(box, items)
    BoxPacker.container [box.width, box.height, box.length], label: box.provider, weight_limit: box.weight do
      items.each do |item|
        add_item [item.product.width, item.product.height, item.product.length], label: item.product.url, weight: item.product.weight, quantity: item.quantity
      end
      pack!
    end
  end


  def get_rates_from_shipper(shipper, origin, destination, packages)
    response = shipper.find_rates(origin, destination, packages)
    response.rates.sort_by(&:price)
  end


  def fedex_rates(origin, destination, packages)
    fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'])
    get_rates_from_shipper(fedex, origin, destination, packages).delete_if{|val| (val.service_name.include?("Envelope") || val.service_name.include?("Letter"))}
  end

  def usps_rates(origin, destination, packages)
    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'], password: ENV['USPS_PASSWORD'])
    get_rates_from_shipper(usps, origin, destination, packages).delete_if{|val| (val.service_name.include?("Media") || val.service_name.include?("Library") ||  val.service_name.include?("Envelope") || val.service_name.include?("Letter") || val.service_name.include?("Parcel"))}
  end

  def origin
    ActiveShipping::Location.new(company_name: "Custom Shop, LLC",
                                 address1: "7680 N US. HWY 69",
                                 phone: "1-903-768-2498",
                                 country: "US",
                                 state: "Texas",
                                 city: "Alba",
                                 zip: "75410")
  end

  def check?(service)
    !Order.where(id: current_order.id).first.shipping_methods.where(:service_name =>  service).first.nil?
  end

  
end
