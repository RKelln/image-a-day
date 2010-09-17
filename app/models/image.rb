class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attached_file :data, :styles => { :thumb => '64x64>', :icon => '32x32#' }
  
  scope :today, where(:date => Time.now)
  scope :yesterday, where(:date => 1.day.ago)
  scope :latest, order(:date).reverse_order.limit(1)
  
  scope :recent, where('date >= ?', 1.day.ago).order(:date).reverse_order.limit(1)
end
