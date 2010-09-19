class ImagesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml
  
  # GET (/user/:user_id)/images
  # GET (/user/:user_id)/images/:year(/:month(/:day))
  # GET (/user/:user_id)/images?start_date=:start_date&end_date=:end_date
  def index
    @images = Image.where(params_where)

    respond_with @images
  end

  def week
    @user = current_user
    @images = @user.images.order('date DESC').limit(1)

    respond_with @images
  end
  
  # GET /images/1
  def show
    @image = Image.find(params[:id])

    respond_with @image
  end

  # GET /images/upload
  # GET /images/upload/:year/:month/:day
  def upload
    @image = Image.new
    if params[:year]
      @image.date = Time.utc(params[:year], params[:month], params[:day])
    else
      @image.date = Time.now
      # TODO: bedtime!
    end
    
    respond_with @image
  end

  # POST /images
  def create
    @image = Image.new(params[:image])
    @image.user_id = current_user.id
    
    if @image.save
      redirect_to @image, :notice => 'Image uploaded'
    else
      render :action => 'upload'
    end
  end

  # DELETE /images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    
    flash[:notice] = 'Deleted image'

    respond_with @image
  end

  private

  # massage incoming params into a meaningful index by context
  def params_where
    pr = params
    
    pr.delete 'controller'
    pr.delete 'action'
    
    pr[:user_id]=current_user.id unless pr[:user_id]
    
    if pr[:year]
      params[:date] = Time.utc(params[:year], params[:month], params[:day])
      pr.delete(:year)
      pr.delete(:month)
      pr.delete(:day)
    elsif pr[:start_date]
      pr[:date] = pr[:start_date]..pr[:end_date]
      pr.delete(:start_date)
      pr.delete(:end_date)
    end
    
    return pr
  end
end
