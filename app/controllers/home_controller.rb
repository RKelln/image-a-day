class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @images = @user.images.order('date DESC')
  end

end
