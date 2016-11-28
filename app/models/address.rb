class Address < ActiveRecord::Base
  belongs_to :user
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validate :address_line
  validates :country, :presence => true
  validates :state, :presence => true
  validates :city, :presence => true
  validates :zip, :presence => true
  before_validation :default_values


  def default_values
    self.prefix = self.prefix.strip.downcase
    self.first_name = self.first_name.strip.downcase
    self.middle_name = self.middle_name.strip.downcase
    self.last_name = self.last_name.strip.downcase
    self.suffix = self.suffix.strip.downcase
    self.company = self.company.strip.downcase
    self.phone = self.phone.strip.downcase
    self.fax = self.fax.strip.downcase
    self.address_line1 = self.address_line1.strip.downcase
    self.address_line2 = self.address_line2.strip.downcase
    self.country = self.country.strip.downcase
    self.state = self.state.strip.downcase
    self.city = self.city.strip.downcase
    self.zip = self.zip.strip.downcase
  end


  def state_code
    if self.state.length > 2
      puts code = ::States.key(self.state.titleize)
      if !code.nil?
        code.upcase
      else
        self.state.upcase
      end
    else
      self.state.upcase
    end
  end

  def address_line
    unless !address_line1.empty? or !address_line2.empty?
      errors.add(:base, "At least one address line must be supplied")
    end
  end

  def display
    (name + ", " + (address_line1.nil? ? address_line2.to_s : address_line1.to_s) + ", " + city.to_s + ", " + state.to_s + ", " + zip.to_s + ", " +  ISO3166::Country[country.to_s].to_s).titleize
  end


  def name
    (prefix.to_s + " " + first_name.to_s + " " + middle_name.to_s + " " + last_name.to_s + " " + suffix).titleize
  end

  def location
    ((address_line1.nil? ? address_line2.to_s : address_line1.to_s) + ", " + city.to_s + ", " + state.to_s + ", " + zip.to_s + ", " +  ISO3166::Country[country.to_s].to_s).titleize
  end
  
end
