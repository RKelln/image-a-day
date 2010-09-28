class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :js

  def index
    @users = User.only_active

    respond_with @users
  end

  def show
    @user = User.find(params[:id])
    @images = @user.images.paginate(:page => params[:page])

    respond_with @user
  end

  def create
    # TODO: real authentication
    unless current_user.admin?
      redirect_to :back, :notice => 'User creation failed: you must be an admin'
    end

    @user = User.new(params[:user])

    # FIXME:default password to be the user email, replace with devise random password?
    @user.password = @user.email

    if @user.save
      redirect_to :back, :notice => 'User created'
    else
      redirect_to :back, :error => 'User creation failed'
    end
  end

  def update
    # only allow admins to update other users, but users can update themselves

    if params[:id] and current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
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
end # UserController
