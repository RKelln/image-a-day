# NOTE: This class exists to let us use some, but not all, of devise :registerable
# We do not want a public-facing sign_up
# There is very likely a better way to do this
class RegistrationsController < ApplicationController
  prepend_before_filter :authenticate_admin, :only => :create
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  include Devise::Controllers::InternalHelpers
  
  layout 'application'

  # GET /resource/sign_up
  # REMOVED

  # POST /users
  # NOTE: this used to live in UsersController and was moved because devise :registerable re-routes us
  def create
    # TODO: real authentication
    # authenticate_admin before filter ought to be doing this now
    #unless current_user.admin?
    #  redirect_to :back, :notice => 'User creation failed: you must be an admin'
    #end

    @user = User.new(params[:user])

    # FIXME:default password to be the user email, replace with devise random password?
    @user.password = @user.email

    if @user.save
      flash[:notice] = 'User created'
      redirect_to :back
    else
      flash[:error] = "User creation failed: #{@user.errors}"
      redirect_to :back
    end
  end

  # GET /users/edit
  def edit
    render_with_scope :edit
  end

  # PUT /users
  def update
    if resource.update_with_password(params[resource_name])
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  # DELETE /users
  def destroy
    resource.destroy
    set_flash_message :notice, :destroyed
    sign_out_and_redirect(self.resource)
  end

  protected

    def authenticate_admin
      warden.authenticate!
      return warden.user.admin
    end
  
    # Authenticates the current scope and gets a copy of the current resource.
    # We need to use a copy because we don't want actions like update changing
    # the current user in place.
    def authenticate_scope!
      send(:"authenticate_#{resource_name}!")
      self.resource = resource_class.find(send(:"current_#{resource_name}").id)
    end
end
