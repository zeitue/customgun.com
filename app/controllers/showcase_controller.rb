class ShowcaseController < ApplicationController
  def about
  end

  def alchemist_series
  end

  def boddington_rifle_project
  end

  def bracelet_helpers
  end

  def contact
  end

  def custom_rifles
  end

  def engraving
  end

  def events
  end

  def finishes
  end

  def gun_fitting
  end

  def gun_parts
  end

  def guns_for_sale
  end

  def gunsmithing
  end

  def home
  end

  def key_chains
  end

  def leather_wrap_pads
  end

  def media
  end

  def payment_and_shipping
  end

  def pens
  end

  def pistols
  end

  def restoration
  end

  def shotguns
  end

  def stock_work
  end

  def synthetic_rifles
  end

  def taylors_pens_and_gifts
  end

  def trophy_room
  end

  def wine_stoppers
  end

  def download_avani
    send_file Rails.root.join('app', 'assets', 'odt', 'avani.odt'), type: 'application/vnd.oasis.opendocument.text', x_sendfile: true
  end

  def download_ember
    send_file Rails.root.join('app', 'assets', 'odt', 'ember.odt'), type: 'application/vnd.oasis.opendocument.text', x_sendfile: true
  end

  def download_zephyr
    send_file Rails.root.join('app', 'assets', 'odt', 'zephyr.odt'), type: 'application/vnd.oasis.opendocument.text', x_sendfile: true
  end
end
