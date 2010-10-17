class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :create_comment

  def create_comment
    #@comment = Comment.new
  end

  def index
    @user = current_user
    @images = Image.recent
  end

  def week
    if params[:end_date]
        @date = Date.parse(params[:end_date])
        if @date < Date.today
            @next_date = @date + 7.days
            @next_date = Date.today if @next_date > Date.today
        end
    else
        @date = Date.today
    end
    @prev_date = @date - 7.days
    
    @user = current_user
    @weekly_images = Array.new
    for user in User.only_active
      if user != @user
        @weekly_images << {:user => user, :images => user.weekly_images(@date)}
      end
    end
    # TODO: sort by relationship / priority / user ordering

    # TODO: place current_user first
    #@my_weekly_images.insert(0, {:user => @user, :images => @user.weekly_images})
  end

  def month
    # an entire month of images for one user, that includes the images for
    # previous and next months that would show on the same month calendar

    # find all the weeks in the month and then get the weekly images for each week
    if params[:month] and params[:year]
      date = Date.new(params[:year].to_i, params[:month].to_i) # NOTE: Date.new fails on string parameters
      @next_date = date + 1.month
      @next_date = nil if @next_date > Date.today
    else
      date = Date.today
    end
    @prev_date = date - 1.month
    
    @weeks = Array.new
    for week in weeks_in_month(date)
      @weeks << Image.where(:user_id => current_user).week(week)
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
      first_of_week.step(date.end_of_month, 1.week) { |d|
        weeks << (d..(d + 6.days))
      }
      weeks
    end
end
