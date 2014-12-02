class UsersController < ApplicationController
  before_filter :authenticate_user!
  prepend_before_filter :authenticate_admin, :only => :create
  respond_to :html, :xml, :js

  def index
    @users = User.only_active

    respond_with @users
  end

def create
    @user = User.new(params[:user])
    # set deafult password to email
    @user.password = @user.email
    @user.password_confirmation = @user.email

    if @user.save
      flash[:notice] = 'User created'
      redirect_to :back
    else
      flash[:error] = "User creation failed: #{@user.errors}"
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
    @images = @user.images.by_date.paginate(:page => params[:page])
    @joined = @user.created_at.to_date
    @image_count = @user.images.count
    @missing_count = [0, @image_count - (Date.today - @joined).to_i].max
    @comment_count = Comment.by_user(@user).count
    respond_with @user
  end

  def update
    # only allow admins to update other users, but users can update themselves

    if params[:id] and authenticate_admin
      @user = User.find(params[:id])
    elsif current_user.id == params[:id]
      @user = current_user
    else
      # non-admins not authorized to update other users
      flash[:error] = "ERROR: You are not an admin.  You cannot modify this user."

      # TODO: this is such a cop-out.  Isn't there a _real_ way to do this?
      redirect_to :back unless request.xhr?
      return
    end

    if @user.update_attributes(params[:user])
      flash[:success] = "Updated #{@user.name}: #{params[:user]}"
    else
      flash[:error] = "ERROR: Cannot update #{@user.name}: #{@user.errors}"
    end

    respond_with(@user, :location => :back) do |format|
      format.js { render :layout => false }
    end

  end # update

  private

  def authenticate_admin
    current_user.admin?
  end

end # UserController
