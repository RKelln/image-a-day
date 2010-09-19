class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  has_attached_file :data, :styles => { :thumb => '64x64>', :icon => '32x32#' }
  
  scope :today, where(:date => Time.now)
  scope :yesterday, where(:date => 1.day.ago)
  scope :latest, order(:date).reverse_order.limit(1) # can't use .first() here
  
  def self.week(last_date=nil)
    days = 7
    last_date = Time.now unless last_date
    images = where('date <= ?', last_date).order(:date).reverse_order.limit(days)
    
    return date_matrix(images, last_date, days)
  end
  
  def self.month(date=nil)
    date = Time.now unless date
    first_date = Time.new(date.year, date.month)
    last_date = first_date + 1.month - 1.days
    days = ((last_date - first_date) / 86400) + 1 # TODO: is there a ruby way to do this?
    
    images = where(:date => first_date..last_date)

    return date_matrix(images, last_date, days)
  end
  
  scope :recent, where('date >= ?', 1.day.ago).order(:date).reverse_order.limit(1)
  
  private
  
  def self.date_matrix(images, last_date, days)
    matrix = []
    (0..days).each do |d|
      matrix[d] = images.where(:date => last_date - d.days)
      matrix[d] = nil if matrix[d].empty?
    end
    return matrix
  end
end
