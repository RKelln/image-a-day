class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @images = Image.recent
    #@images = @user.images.order('date DESC')
  end

  def week
    @user = current_user

    # TODO: only active users
    @weekly_images = Array.new
    for user in User.all
      if user != @user
        @weekly_images << {:user => user, :images => user.weekly_images}
      end
    end
    # TODO: sort by relationship / priority / user ordering

    # TODO: place current_user first
    @weekly_images.insert(0, {:user => @user, :images => @user.weekly_images})
  end

  def month
    # TODO: only active users
    @weekly_images = Array.new
    for user in User.all
      @weekly_images << {:user => user, :images => user.weekly_images}
    end
    # TODO: place current_user first
  end
end
