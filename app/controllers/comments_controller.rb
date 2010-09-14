class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml

  # GET /comments
  def index
    @comments = Comment.all

    respond_with @comments
  end

  # POST /comments
  # POST /images/:image_id/comments
  def create
    if params[:image_id]
      @image = Image.find(params[:image_id])
      @comment = @image.comments.create(params[:comment])
    else
      @comment = Comment.new(params[:comment])
    end
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back, :notice => 'Comment created'
    else
      render :action => 'new'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back
  end
end
