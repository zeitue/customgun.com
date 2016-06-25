class Address < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true
  validate :address_line
  validates :country, :presence => true
  validates :state, :presence => true
  validates :city, :presence => true
  validates :zip, :presence => true

  def address_line
    unless !address_line1.empty? or !address_line2.empty?
      errors.add(:base, "At least one address line must be supplied")
    end
  end
end
