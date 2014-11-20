class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :create_comment

  def create_comment
    #@comment = Comment.new
  end

  def index
    if params[:date]
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end
    # TODO: use user's timezone/day
    @prev_date = @date - 1.day
    @next_date = @date + 1.day

    @user = current_user
    @images = Image.recent(@date)
  end

  def week
    if params[:end_date]
        @date = Date.parse(params[:end_date])
        if @date < Date.today
            @next_date = @date + 1.day
        end
    else
        @date = Date.today
    end
    @prev_date = @date - 1.week
    @user = current_user
    @weekly_images = Array.new
    for user in User.only_active
      if user != @user
        @weekly_images << {:user => user, :images => user.weekly_images(@date)}
      end
    end
    # TODO: sort by relationship / priority / user ordering
    # sort by number of weekly images and alphebetically
    @weekly_images = @weekly_images.sort_by { |x| [-count_images_in(x[:images]), x[:user].nickname] }
  end

  def month
    # an entire month of images for one user, that includes the images for
    # previous and next months that would show on the same month calendar

    # current user unless specified
    @user = params[:id] ? User.find(params[:id]) : current_user

    # find all the weeks in the month and then get the weekly images for each week
    if params[:month] and params[:year]
      @date = Date.new(params[:year].to_i, params[:month].to_i) # NOTE: Date.new fails on string parameters
      # if the date is within the current moth then set the day to the current day (otherwise defaults to the 1st of the month)
      @date = Date.new(params[:year].to_i, params[:month].to_i, Date.today.day) if helper.current_month?(@date)
      @next_date = @date >> 1 # add 1 month
      @next_date = nil if @next_date > Date.today
    else
      @date = Date.today
    end
    @prev_date = @date << 1 # subtract 1 month
    @current_month = @date.strftime('%B %Y')

    @weeks = Array.new
    for week in weeks_in_month(@date)
      @weeks << Image.where(:user_id => @user).week(week)
    end

  end

  def admin
    @new_user = User.new
    @users = User.order('users.id')
    # TODO: recent logins
    @logins = []
    # TODO: recent comments
    @comments = []
    # TODO: recent errors / warnings
    @errors = []

    render :layout => 'application'
  end

  protected
    def weeks_in_month(date=nil)
      date = Date.today unless date
      first_of_week = date.beginning_of_month.beginning_of_week
      weeks = Array.new
      first_of_week.step(date.end_of_month, 7) { |d|
        weeks << (d..(d + 6.days))
      }
      weeks
    end

    # counts how many images (not Absent images) in range
    def count_images_in(images)
      (images.select {|image| image.is_a? Image and not image.is_a? Image::AbsentImage }).length
    end
end
