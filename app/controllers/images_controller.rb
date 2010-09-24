class ImagesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml

  # GET (/user/:user_id)/images
  # GET (/user/:user_id)/images/date/:year(/:month(/:day))
  # GET (/user/:user_id)/images?start_date=:start_date&end_date=:end_date
  def index
    @images = Image.where(params_where).paginate(:page => params[:page])

    respond_with @images
  end

  # GET /images/:id
  def show
    @image = Image.find(params[:id])
    @image_comments = @image.comments.reverse
    respond_with @image
  end

  # GET /images/data/:user_id/:year/:month/:day/:style
  # :path => ':rails_root/public/system/:year_month_day:opt_style/:user_:yyyy_:yday.:extension'
  def data
    style = params[:style]
    match_params = params.slice :user_id,:year,:month,:day
    logger.debug "DATA matching #{match_params}"
    @image = Image.where(params_where(match_params))
    logger.debug "DATA matched #{@image}"

    logger.debug "DATA sending #{@image.first.data.path(style)}"
    send_file @image.first.data.path(style), :type => @image.first.data.content_type
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

    unless current_user.admin? or @image.user_id == current_user.id
      flash[:warn] = "WARNING: You do not have permission to delete this image"
    else
      flash[:error] = "ERROR: Cannot delete image #{@image.errors}" unless @image.destroy
    end

    flash[:notice] = 'Deleted image'

    respond_with(@image, :location => root_path) do |format|
      format.js {render :text=> "Image deleted"}
    end
  end

  private

  # massage incoming params into a meaningful index by context
  def params_where(match_params = nil)
    match_params = params unless match_params

    match_params.delete 'controller'
    match_params.delete 'action'

    match_params[:user_id]=current_user.id unless match_params[:user_id]

    if match_params[:year]
      match_params[:date] = Time.utc(match_params[:year], match_params[:month], match_params[:day])
      match_params.delete(:year)
      match_params.delete(:month)
      match_params.delete(:day)
    elsif match_params[:start_date]
      match_params[:date] = match_params[:start_date]..match_params[:end_date]
      match_params.delete(:start_date)
      match_params.delete(:end_date)
    end

    return match_params
  end
end
