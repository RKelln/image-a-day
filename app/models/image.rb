﻿class Image < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  # TODO: unique constraint by user/date

  #validates :description, :length => {:maximum => 10000}
  #validates :date, :presence => true

  has_attached_file :data, :styles => { :thumb => '64x64>', :icon => '32x32#', :display => '976x976>' },
          :convert_options => {:all => '-auto-orient'},
          :path => ':rails_root/assets/images/:year_month_day:opt_style/:user_id_:year_:yday.:extension',
          :url => '/images/data/:user_id/:year/:month/:day/:style'

  validates_attachment :data, :presence => true,
    :content_type => { :content_type => /\Aimage/i },
    :file_name => { :matches => [/png\Z/i, /jpe?g\Z/i, /gif\Z/i] },
    :size => { :in => 0..10.megabytes }

  validates :data_file_name, :presence => true

  scope :today, where(:date => Time.now)
  scope :yesterday, where(:date => 1.day.ago)
  scope :by_date, order("date DESC") # backwards through time by default
  # TODO: latest to use user time zone!?
  scope :latest, by_date.where("date <= ?", Time.zone.now).limit(1) # can't use .first() here
  scope :since,  lambda {|date| where("date > ?", date) }
  scope :before, lambda {|date| where("date < ?", date) }
  scope :next,   lambda {|image| since(image.date).where(:user_id => image.user_id).order(:date).limit(1)}
  scope :prev,   lambda {|image| before(image.date).where(:user_id => image.user_id).by_date.limit(1)}

  def to_s
    "Image: #{user.nickname} [#{date}]: #{data_file_name}"
  end

  # accepts a specific date, in which case it will return a weeks wroth of images leading up to
  # ad including that date. Also accepts a range that is a week long
  def self.week(last_date=nil)
    if last_date.is_a? Range
      range = last_date
    else
      last_date ||= Date.today
      range = (last_date - 6.days)..last_date
    end

    images = where(:date => range).by_date

    return date_matrix(images, range)
  end

  def self.month(date=nil)
    date = Date.today unless date
    first_date = Date.new(date.year, date.month)
    last_date = first_date + 1.month - 1.days

    images = where(:date => first_date..last_date)

    return date_matrix(images, first_date..last_date)
  end

  # NOTE: named scope here doesn't work, define a class method instead
  #scope :recent, scoped.find_by_sql("SELECT * FROM images WHERE date >= 'yesterday' AND date = (SELECT date FROM images AS recent_images WHERE recent_images.user_id = images.user_id ORDER BY date DESC LIMIT 1);")
  def self.recent(today="today")
    if today == "today"
      yesterday = "yesterday"
    else
      yesterday = today - 1.day
    end
    #return find_by_sql("SELECT * FROM images WHERE date >= #{yesterday} AND date <= #{today} AND date = (SELECT date FROM images AS recent_images WHERE recent_images.user_id = images.user_id ORDER BY date DESC LIMIT 1);")
    image_range = Image.where(:date => yesterday..today)

    # for each user get their most recent image within the date range
    users_in_range = image_range.select('DISTINCT user_id')

    # create a list of the most recent images for each user in range
    recent_images_per_user = []
    for image in users_in_range
      recent_images_per_user += image_range.where("user_id = #{image.user_id}").by_date.take(1)
    end
    recent_images_per_user
  end

  def short_date
    date.strftime('%b %d')
  end

  def long_date
    date.strftime('%d %B %Y')
  end

  class AbsentImage
    attr_accessor :upload_date

    def initialize(upload_date)
      @upload_date = Date.parse(upload_date)
    end

    def to_s
      "AbsentImage: ##{@upload_date.yday} (#{short_date})"
    end

    def short_date
      @upload_date.strftime('%b %d')
    end

    def long_date
      @upload_date.strftime('%d %B %Y')
    end

    def date
      @upload_date
    end
  end

  private

  def self.date_matrix(images, date_range)
    matrix = []
    date_range.each_with_index do |day, i|
      matrix[i] = images.where(:date => day).take(1)
      if matrix[i].empty?
        matrix[i] = AbsentImage.new(day.to_s)
      else
        matrix[i] = matrix[i].first #remove from array
      end
    end
    return matrix
  end
end
