class Address < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :address_line
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  before_validation :default_values

  def default_values
    self.prefix = prefix.strip.downcase
    self.first_name = first_name.strip.downcase
    self.middle_name = middle_name.strip.downcase
    self.last_name = last_name.strip.downcase
    self.suffix = suffix.strip.downcase
    self.company = company.strip.downcase
    self.phone = phone.strip.downcase
    self.fax = fax.strip.downcase
    self.address_line1 = address_line1.strip.downcase
    self.address_line2 = address_line2.strip.downcase
    self.country = country.strip.downcase
    self.state = state.strip.downcase
    self.city = city.strip.downcase
    self.zip = zip.strip.downcase
  end

  def state_code
    if state.length > 2
      puts code = ::States.key(state.titleize)
      if !code.nil?
        code.upcase
      else
        state.upcase
      end
    else
      state.upcase
    end
  end

  def address_line
    unless !address_line1.empty? || !address_line2.empty?
      errors.add(:base, 'At least one address line must be supplied')
    end
  end

  def display
    (name + ', ' + (address_line1.nil? ? address_line2.to_s : address_line1.to_s) + ', ' + city.to_s + ', ' + state.to_s + ', ' + zip.to_s + ', ' + ISO3166::Country[country.to_s].to_s).titleize
  end

  def name
    (prefix.to_s + ' ' + first_name.to_s + ' ' + middle_name.to_s + ' ' + last_name.to_s + ' ' + suffix).titleize
  end

  def location
    ((address_line1.nil? ? address_line2.to_s : address_line1.to_s) + ', ' + city.to_s + ', ' + state.to_s + ', ' + zip.to_s + ', ' + ISO3166::Country[country.to_s].to_s).titleize
  end
end
