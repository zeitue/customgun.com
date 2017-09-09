module ProductsHelper
  def m_yd(value)
    value.round(0).to_s + ' m / ' + (value * 1.0936).round(0).to_s + ' yd'
  end

  def mm_thou(value)
    value.round(1).to_s + ' mm / ' + (value * 39.3701).round(1).to_s + ' thou'
  end

  def dimensions_as_m(product)
    buffer = (product.length / 100).to_s + ' x '
    buffer += (product.width / 100).to_s + ' x '
    buffer += (product.height / 100).to_s + ' m.'
    buffer
  end

  def dimensions_as_cm(length, width, height)
    buffer = length.to_s + ' x '
    buffer += width.to_s + ' x '
    buffer += height.to_s + ' cm.'
    buffer
  end

  def dimensions_as_inches(length, width, height)
    buffer = (length / 2.54).round(2).to_s + ' x '
    buffer += (width / 2.54).round(2).to_s + ' x '
    buffer += (height / 2.54).round(2).to_s + ' in.'
    buffer
  end

  def weight_as_metric(weight)
    if weight < 1000
      weight.to_s + ' g.'
    else
      (weight / 1000).round(0).to_s + ' kg.'
    end
  end

  def weight_as_imperial(weight)
    weight = (((weight / 1000) * 35.274) / 16)
    pounds = weight.floor
    weight -= pounds

    ounces = (weight * 16).floor
    weight -= ounces / 16

    drachm = (weight * 256).floor
    weight -= drachm / 256

    grains = (weight * 7000).floor

    buffer = ''

    if pounds >= 1
      (buffer += pounds.to_s + ' lb. ')
    end

    if ounces >= 1
      (buffer += ounces.to_s + ' oz. ')
    end

    if drachm >= 1 && pounds < 1
      (buffer += drachm.to_s + ' dr. ')
    end

    if grains >= 1 && pounds < 1 && ounces < 1
      (buffer += grains.to_s + ' gr. ')
    end

    buffer
  end

  def get_shipping_phase(order)
    case order.phase
    when 0
      "Initial"
    when 2
      "Address Selection"
    when 3
      "Shipping Selection"
    when 4
      "Order Review"
    when 5
      "Payment Processing"
    else
      "Initial"
    end
  end
end
