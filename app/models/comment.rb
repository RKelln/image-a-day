class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  #validates :text, :presence => true, :length => {:maximum => 10000}
  #validates :user_id, :presence => true
  validates_presence_of :text

  def to_s
    "Comment[#{id}, #{user_id}]: #{created_at} \"#{text}\""
  end
  
  def date
    created_at
  end
end
