module ProductsHelper
  def dimensions_as_m(product)
    buffer = (product.length / 100).to_s + ' x '
    buffer += (product.width / 100).to_s + ' x '
    buffer += (product.height / 100).to_s + " m."
  end
  def dimensions_as_cm(product)
    buffer = product.length.to_s + ' x '
    buffer += product.width.to_s + ' x '
    buffer += product.height.to_s + " cm."
  end
  def dimensions_as_inches(product)
    buffer = (product.length / 2.54).round(2).to_s + ' x '
    buffer += (product.width / 2.54).round(2).to_s + ' x '
    buffer += (product.height / 2.54).round(2).to_s + " in."
  end

  def weight_as_metric(product)
    if(product.weight < 1)
      (product.weight * 1000).round(0).to_s + " g."
    else
      product.weight.to_s + " kg."
    end
  end

  def weight_as_imperial(product)
    weight = product.weight * 35.274
    pounds = (weight / 16).round(0)
    ounces = (weight % 16).round(0)
    buffer = ""
    buffer += pounds.to_s + " lb." unless (pounds == 0)
    buffer += ounces.to_s + " oz." unless (ounces == 0)
    buffer
  end

end
