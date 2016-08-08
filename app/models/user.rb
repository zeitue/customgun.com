class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :addresses
  after_create :create_cart
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  before_destroy :destroy_associated
  accepts_nested_attributes_for :addresses

 def move_to(user)
  todos.update_all(user_id: user.id)
 end



  private

  def create_cart
      Order.create(user_id: self.id) 
  end

  def destroy_associated
    self.orders.destroy_all
    self.addresses.destroy_all
  end
end
