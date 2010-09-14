class ImagesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  
  # GET /images
  # GET /images.xml
  def index
    @user = current_user
    @images = @user.images

    respond_with @images
  end

  def week
    @user = current_user
    @images = @user.images.order('date DESC').limit(1)

    respond_with @images
    #render :action => 'index'
  end
  
  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_with @image
  end

  # GET /images/upload
  # GET /images/upload.xml
  def upload
    @image = Image.new
    
    respond_with @image
  end

  # POST /images
  # POST /images.xml
  def create
    @image = Image.new(params[:image])
    @image.user_id = current_user.id
    now = Time.now
    today = Time.utc(now.year,now.month,now.day)
    @image.date = today
    
    if @image.save
      redirect_to @image, :notice => 'Image uploaded'
    else
      render :action => 'upload'
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    
    flash[:notice] = 'Deleted image'

    respond_with @image
  end
end
