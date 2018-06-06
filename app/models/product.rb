class Product < ActiveRecord::Base
  include FriendlyId
  friendly_id :url
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates_presence_of :shipper
  validate :shipping_constraint
  has_many :photos
  accepts_nested_attributes_for :photos
  before_validation :default_values
  before_destroy :destroy_associated
  before_save :clean_up
  belongs_to :shipper



  def default_values
    self.title = title.to_s.strip.downcase
    self.manufacturer = manufacturer.to_s.strip.downcase
    self.model = model.to_s.strip.downcase
    self.type_field = type_field.to_s.strip.downcase
    self.style_field = style_field.to_s.strip.downcase
    self.material = material.to_s.strip.downcase
    self.caliber = caliber.to_s.strip.downcase
    self.part_number = part_number.to_s.strip.downcase
    self.url = title.strip.parameterize
    self.tags = tags.to_s.strip.downcase
    self.shipped_by = shipped_by.blank? ? nil : shipped_by.to_s.strip.downcase
    self.diopter_adjustment = diopter_adjustment.to_s.strip.downcase
    self.elevation_travel = elevation_travel.to_s.strip.downcase
    self.windage_travel = windage_travel.to_s.strip.downcase
    self.total_travel = total_travel.to_s.strip.downcase
    self.position_of_reticle = position_of_reticle.to_s.strip.downcase
    self.available_reticles = available_reticles.to_s.strip.downcase
  end

  def clean_up
    self.store = store.to_s.strip.downcase.parameterize.gsub('-', '_')
  end


  def destroy_associated
    photos.destroy_all
  end

  def shipping_constraint
    unless self.compressible ||
           (self.shipping_height.to_f >= self.height.to_f &&
           self.shipping_width.to_f  >= self.width.to_f  &&
           self.shipping_length.to_f >= self.length.to_f &&
           self.shipping_weight.to_f >= self.weight.to_f)
      errors.add(:base, 'It is not possible to place a larger object inside a smaller object')
    end
  end

  def get_price
    if sale
      sale_price
    else
      price
    end
  end

  def get_savings
    price - sale_price
  end

  def get_percent_saved
    ((price - sale_price) / price * 100).round(2)
  end

  def update_on_sale
    if self.sale_end && Time.now > self.sale_end
      self.sale = false;
      self.sale_end = nil
      self.save!
    end
  end

  def self.search(search)
    ss = search.to_s.strip.downcase
    v = nil
    if ss.start_with?("'") && ss.ends_with?("'")
      s = ss[1..-2]
      where("title LIKE ? OR model LIKE ? OR manufacturer LIKE ? OR part_number LIKE ?", "%#{s}%", "%#{s}%", "%#{s}%", "%#{s}%")
    else
      ss.split.each do |s|
        if v
          v = v + where("title LIKE ? OR model LIKE ? OR manufacturer LIKE ? OR part_number LIKE ?", "%#{s}%", "%#{s}%", "%#{s}%", "%#{s}%")
        else
          v = where("title LIKE ? OR model LIKE ? OR manufacturer LIKE ? OR part_number LIKE ?", "%#{s}%", "%#{s}%", "%#{s}%", "%#{s}%")
        end
      end
      v.uniq
    end
  end

  def self.department(value)
    where("store = ?", "#{value}")
  end

  def self.qmodel(value)
    where("model = ?", "#{value}")
  end

  def self.qmanufacturer(value)
    where("manufacturer = ?", "#{value}")
  end

  def self.qpart_number(value)
    where("part_number = ?", "#{value}")
  end

  def self.qmaterial(value)
    where("material = ?", "#{value}")
  end

  def self.qcaliber(value)
    where("caliber = ?", "#{value}")
  end

  def self.qbarrel_length(value)
    where("barrel_length = ?", "#{value}")
  end

  def self.qtype_field(value)
    where("type_field = ?", "#{value}")
  end

  def self.qstyle_field(value)
    where("style_field = ?", "#{value}")
  end

  def self.qfield_of_view_low_power(value)
    where("field_of_view_low_power = ?", "#{value}")
  end

  def self.qfield_of_view_high_power(value)
    where("field_of_view_high_power = ?", "#{value}")
  end

  def self.qdiopter_adjustment(value)
    where("diopter_adjustment = ?", "#{value}")
  end

  def self.qeye_relief(value)
    where("eye_relief = ?", "#{value}")
  end

  def self.qexit_pupil_low_power(value)
    where("exit_pupil_low_power = ?", "#{value}")
  end

  def self.qexit_pupil_high_power(value)
    where("exit_pupil_high_power = ?", "#{value}")
  end

  def self.qelevation_travel(value)
    where("elevation_travel = ?", "#{value}")
  end

  def self.qwindage_travel(value)
    where("windage_travel = ?", "#{value}")
  end

  def self.qmoa_per_click_upper(value)
    where("moa_per_click_upper = ?", "#{value}")
  end

  def self.qmoa_per_click_lower(value)
    where("moa_per_click_lower = ?", "#{value}")
  end

  def self.qparallax_compensation(value)
    where("parallax_compensation = ?", "#{value}")
  end

  def self.qtotal_travel(value)
    where("total_travel = ?", "#{value}")
  end

  def self.qtube_diameter(value)
    where("tube_diameter = ?", "#{value}")
  end

  def self.qposition_of_reticle(value)
    where("position_of_reticle = ?", "#{value}")
  end

  def self.qavailable_reticles(value)
    where("available_reticles = ?", "#{value}")
  end

  def self.qsale(value)
    where("sale = ?", "#{value}")
  end

  def self.qorder(value)
    if value == 't'
      order('created_at DESC')
    end
  end
end
