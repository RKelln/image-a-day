class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :js

  # GET /comments
  def index
    @comments = Comment.all
    # TODO: paginate and more comments button???
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

    flash[:error] = "ERROR: Cannot add comment: #{@comment.errors}" unless @comment.save

    respond_with(@comment, :location => :back) do |format|
      # TODO: write a custom responder that can handle js responses correctly (on error)
      format.js {
        if @comment.errors.any?
          render :text => "Cannot add comment"
        else
          render @comment, :layout => false
        end
      }
    end
  end

  # TODO: remove this action once comments are ajax
  # GET /comments/:id/edit/
  def edit
    @comment = Comment.find(params[:id])
  end

  # PUT /comments/:id/update
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to :back, :notice => 'Comment was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment = Comment.find(params[:id])

    unless current_user.admin? or @comment.user_id == current_user.id
      flash[:warn] = "WARNING: You do not have permission to delete comment"
    else
      flash[:error] = "ERROR: Cannot delete comment: #{@comment.errors}" unless @comment.destroy
    end
    respond_with(@comment, :location => :back) do |format|
      format.js {render :text=> "Comment deleted"}
    end
  end
end
