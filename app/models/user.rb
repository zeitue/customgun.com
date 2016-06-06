class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  after_create :create_cart


 def move_to(user)
  todos.update_all(user_id: user.id)
 end



  private

  def create_cart
      Order.create(user_id: self.id) 
  end
end
