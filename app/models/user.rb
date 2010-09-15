class User < ActiveRecord::Base
  # Include default devise modules. Others available are:  
  # :token_authenticatable, :lockable, :timeoutable and :activatable  
  # :confirmable  
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable  
  
  # Setup accessible (or protected) attributes for your model  
  attr_accessible :email, :password, :password_confirmation, :name, :nickname
  
  has_many :images
end
