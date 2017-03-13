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
    product_ids = @order.items.map(&:product_id)
    @shippers = Shipper.where(id: Product.where(id: product_ids).uniq.pluck(:shipper_id).sort_by { |i| [i ? 1 : 0, i] })
    @shippers.count.times { @order.shipping_methods.build }
    @packed = []
    @rates = []
    destination = make_active_location(@order.get_address)

    @shippers.each do |shipper|
      origin = make_active_location(shipper.address)
      if shipper.scheme == 0
        pack = []
        rate = []
        @items = @order.items.joins(:product).where(products: { shipper_id: shipper.id })
        if @items.count > 0

          if shipper.usps
            usps_packed = make_packages('usps', @items)
            pack.push((usps_packed.include? nil) ? [] : usps_packed)
            if !usps_packed.include? nil
              usps_packages = make_active_packages(usps_packed)
              rate.push(usps_rates(origin, destination, usps_packages))
            end
          end

          if shipper.fedex
            fedex_packed = make_packages('fedex', @items)
            pack.push((fedex_packed.include? nil) ? [] : fedex_packed)
            if !fedex_packed.include? nil
              fedex_packages = make_active_packages(fedex_packed)
              rate.push(fedex_rates(origin, destination, fedex_packages))
            end
          end

          if shipper.ups
            ups_packed = make_packages('ups', @items)
            pack.push((ups_packed.include? nil) ? [] : ups_packed)
            if !ups_packed.include? nil
              ups_packages = make_active_packages(ups_packed)
              rate.push(ups_rates(origin, destination, ups_packages))
            end
          end

        end
        @rates.push(rate)
        @packed.push(pack)
      end
    end
    @shipping_information = @shippers.zip(@order.shipping_methods, @packed, @rates)
    Rails.cache.delete(:shipping_information)
    Rails.cache.write(:shipping_information, @shippers.zip(@packed))
  end

  def review
    @order = current_order
  end

  def process_order
    @order = current_order
    @shipping_methods = @order.shipping_methods
    if @shipping_methods.count > 0
      @order.shipments.destroy_all
      @order.shipments = []
      @shipping_information = Rails.cache.read(:shipping_information)
      i = 0
      @shipping_information.each do |shipper, packed|
        if shipper.scheme == 0
          if @shipping_methods[i].service_name.downcase.include? 'fedex'
            make_shipments(@order, shipper, packed.find {|p| !p.empty? && p.first.label == 'fedex'}).each { |shipment| @order.shipments.push(shipment) }
          elsif @shipping_methods[i].service_name.downcase.include? 'usps'
            make_shipments(@order, shipper, packed.find {|p| !p.empty? && p.first.label == 'usps'}).each { |shipment| @order.shipments.push(shipment) }
          elsif @shipping_methods[i].service_name.downcase.include? 'ups'
            make_shipments(@order, shipper, packed.find {|p| !p.empty? && p.first.label == 'ups'}).each { |shipment| @order.shipments.push(shipment) }
          end
        elsif shipper.scheme == 1
          @order.shipments.push(make_pack_shipment(@order, shipper))
        elsif shipper.scheme == 2
          @order.shipments.push(make_pack_shipment(@order, shipper))
        end
        i += 1
      end
      @order.shipping = @order.shipping_methods.sum(:price)
      st = @order.get_address.state.to_s.downcase
      if st == 'texas' || st == 'tx' || st == 'lone star state' || st == 'beef state' || st == 'jumbo state' || st == 'super-american state' || st == 'banner state' || st == 'blizzard state'
        @order.tax = ('%.2f' % ((@order.subtotal + @order.shipping).to_f * 0.0675))
      else
        @order.tax = 0.0
      end
      @order.ordered_on = DateTime.now
      @order.save!
      @order.update_order
    end
    redirect_to review_path
  end

  def packaging
    @order = current_order
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

  def make_pack_shipment(order, shipper)
    shipment = Shipment.new(order_id: order.id, shipped_by: shipper.company_name)
    items = order.items.joins(:product).where(products: { shipper_id: shipper.id })
    items.each do |item|
      shipment.units.new(product_id: item.product.id,
                         quantity: item.quantity,
                         price: item.product.get_price)
    end
    shipment
  end

  def make_shipments(order, shipper, packed)
    puts '***********************'
    puts packed
    shipments = []
    packed.each do |entry|
      shipments.push(make_shipment(order, shipper, entry))
    end
    shipments
  end

  def make_shipment(order, shipper, packed)
    shipment = Shipment.new(order_id: order.id, shipped_by: shipper.company_name)
    counts = Hash.new(0)
    packed.packings.first.each { |entry| counts[entry.label] += 1 }
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
    products = [];
    pack.packings.first.each {|e| products.push(e.label)}
    insurance = Product.where(:url => products).sum(:price)
    ActiveShipping::Package.new((pack.weight_limit - pack.packings.first.remaining_weight) * 1.15, [pack.dimensions.x, pack.dimensions.y, pack.dimensions.z], value: insurance, currency: 'USD', insurance_price: insurance, insured_price: insurance)
  end

  def make_active_location(address)
    ActiveShipping::Location.new(name: address.prefix.to_s + ' ' + address.first_name.to_s + ' ' + address.middle_name.to_s + address.last_name.to_s + ' ' + address.suffix.to_s,
                                 address1: address.address_line1,
                                 address2: address.address_line2,
                                 phone: address.phone,
                                 country: address.country,
                                 state: address.state,
                                 city: address.city,
                                 zip: address.zip)
  end

  def make_packages(provider, items)
    individual = items.joins(:product).where(products: { exclusive: true, has_box: false })
    grouped = items.joins(:product).where(products: { exclusive: false, has_box: false })
    selfpacked = items.joins(:product).where(products: { has_box: true })
    packages = []
    individual.each do |item|
      entry = best_fit(provider, [item])
      packages.push(entry)
    end

    while grouped.count > 0
      entry = best_fit(provider, grouped)
      packages.push(entry)
      grouped = remove_from(entry, grouped)
    end

    selfpacked.each do |spack|
      packages.push(spackup(provider, spack))
    end
    packages
  end


  def spackup(provider, item)
    BoxPacker.container [item.product.shipping_width, item.product.shipping_height, item.product.shipping_length], label: provider, weight_limit: item.product.shipping_weight do
      add_item [item.product.shipping_width, item.product.shipping_height, item.product.shipping_length], label: item.product.url, weight: item.product.shipping_weight, quantity: item.quantity
      pack!
    end
  end


  def remove_from(entry, items)
    items_list = items.dup
    if entry
      entry.packings.first.each do |package|
        if items_list.each do |item|
             item.quantity -= 1 if item.product.url == package.label
           end
        end
      end
      items_list.reject { |x| x.quantity == 0 }
    else
      []
    end
  end

  def best_fit(provider, items)
    entries = []
    Box.where(provider: provider).each do |box|
      entries.push(packup(box, items))
    end
    entries.delete_if { |x| x.packings.count == 0 }
    entries = entries.sort_by { |obj| [obj.packings.count, obj.packings.first.remaining_volume] }
    if entries.count > 0
      if entries.first.packings.count > 1
        entries.first.packings.pop(entries.first.packings.count - 1)
      end
    end
    entries.first
  end

  def packup(box, items)
    BoxPacker.container [box.width, box.height, box.length], label: box.provider, weight_limit: box.weight do
      items.each do |item|
        add_item [item.product.shipping_width, item.product.shipping_height, item.product.shipping_length], label: item.product.url, weight: item.product.shipping_weight, quantity: item.quantity
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
    get_rates_from_shipper(fedex, origin, destination, packages).delete_if { |val| (val.service_name.include?('Envelope') || val.service_name.include?('Letter')) }
  end

  def usps_rates(origin, destination, packages)
    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'], password: ENV['USPS_PASSWORD'])
    get_rates_from_shipper(usps, origin, destination, packages).delete_if { |val| (val.service_name.include?('Media') || val.service_name.include?('Library') || val.service_name.include?('Envelope') || val.service_name.include?('Letter') || val.service_name.include?('Parcel')) }
  end

  def check?(service)
    !Order.where(id: current_order.id).first.shipping_methods.where(service_name: service).first.nil?
  end
end
