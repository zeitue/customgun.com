class AlchemistSeriesController < ApplicationController
  def index
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
