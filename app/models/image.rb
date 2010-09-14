class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attached_file :data
end
