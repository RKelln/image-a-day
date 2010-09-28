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
    @user = current_user

    # TODO: only active users
    @weekly_images = Array.new
    for user in User.only_active
      if user != @user
        @weekly_images << {:user => user, :images => user.weekly_images}
      end
    end
    # TODO: sort by relationship / priority / user ordering

    # TODO: place current_user first
    #@my_weekly_images.insert(0, {:user => @user, :images => @user.weekly_images})
  end

  def month
    # TODO: monthly images
    @monthly_images = Array.new
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
end
