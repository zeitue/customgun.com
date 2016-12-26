class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :addresses
  after_create :create_cart
  validates :name, presence: true
  before_destroy :destroy_associated
  accepts_nested_attributes_for :addresses
  has_many :authentications


  def move_to(user)
    todos.update_all(user_id: user.id)
  end

  def create_cart
    Order.create(user_id: id)
  end

  def destroy_associated
    orders.destroy_all
    addresses.destroy_all
    authentications.destroy_all
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if (email.blank? || email =~ /^guest[a-fA-F\d]{0,10}_[\d\D]+@customgun.com/)
    self.name = omniauth['info']['name']
    self.guest = false
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def update_with_password(params={})
    unless self.authentications.empty?
      params.delete(:current_password)
      self.update_without_password(params)
    end
    super
  end
end
