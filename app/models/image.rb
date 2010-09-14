class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 500.kilobytes
                 #:resize_to => '320x200>',
                 #:thumbnails => { :thumb => '100x100>' }

  validates_as_attachment

end
