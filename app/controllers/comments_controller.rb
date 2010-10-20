class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :js

  # GET /comments
  # NOTE: this is only called for AJAX-paginated wall comments, so is not truly an index
  def index
    @comments = Comment.where(:image_id => nil).reverse.paginate(:per_page => 15, :page => params[:wall_page])

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

  # GET /comments/:id/edit/
  def edit
    @comment = safe_find(Comment, params)
    
    respond_with(@comment, :location => :back) do |format|
      format.js { render :partial => "comments/edit", :layout => false}
    end
  end

  # PUT /comments/:id/update
  def update
    @comment = safe_find(Comment, params)
      
    flash[:error] = "ERROR: Cannot update comment" unless @comment.update_attributes(params[:comment])
    
    respond_with(@comment, 
      :location => :back, 
      :notice => 'Comment was successfully updated.') do |format|
      format.js {
        if @comment.errors.any?
          render :text => "Cannot add comment"
        else
          render @comment, :layout => false
        end
      }
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment = safe_find(Comment, params)

    flash[:error] = "ERROR: Cannot delete comment: #{@comment.errors}" unless @comment.destroy

    respond_with(@comment, :location => :back) do |format|
      format.js {render :text=> "Comment deleted"}
    end
  end

end
