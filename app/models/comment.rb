class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  #validates :text, :presence => true, :length => {:maximum => 10000}
  #validates :user_id, :presence => true
  validates_presence_of :text

end
