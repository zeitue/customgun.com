# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def store_dir
    "#{mounted_as}/#{model.product_id}"
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end


  def filename
    super.chomp(File.extname(super)).downcase.parameterize.underscore + '.jpeg' if original_filename.present?
  end
  
  # Create different versions of your uploaded files:

  version :thumb do
    process :resize_and_pad => [240, 160]
  end

  version :xxhdpi do
    process :resize_and_pad => [1600, 960]
  end

  version :xhdpi do
    process :resize_and_pad => [1280, 720]
  end

  version :hdpi do
    process :resize_and_pad => [800, 480]
  end

  version :mdpi do
    process :resize_and_pad => [480, 320]
  end

  version :ldpi do
    process :resize_and_pad => [320, 200]
  end

  version :xxdpi_icon do
    process :resize_and_pad => [144, 144]
  end

  version :xdpi_icon do
    process :resize_and_pad => [96, 96]
  end

  version :hdpi_icon do
    process :resize_and_pad => [36, 36]
  end

  version :mdpi_icon do
    process :resize_and_pad => [72, 72]
  end

  version :ldpi_icon do
    process :resize_and_pad => [36, 36]
  end



  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
