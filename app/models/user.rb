class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :nickname, :active, :admin

  has_many :images

  def weekly_images
    Image.where({:user_id =>id}).week
  end

end
