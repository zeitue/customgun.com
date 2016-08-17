class Box < ActiveRecord::Base
    before_validation :default_values

  def default_values
    self.provider = self.provider.strip.downcase
  end
end
