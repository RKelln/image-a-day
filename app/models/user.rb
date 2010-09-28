class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :nickname, :active, :admin

  # restrict logins to active users
  def self.find_for_authentication(conditions={})
    conditions[:active] = true
    super
  end

  has_many :images

  def weekly_images
    Image.where({:user_id =>id}).week
  end

  scope :only_active, where(:active => true)
end
