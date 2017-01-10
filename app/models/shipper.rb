class Shipper < ActiveRecord::Base
  belongs_to :address

  def scheme_name
    case scheme
    when 0
      'Calculated'
    when 1
      'Flat Rate'
    when 2
      'Digital'
    else
      'Unknown'
    end
  end
end
